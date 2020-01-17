(ns daemon.face.core
  (require
   [daemon.face.repl :as repl]
   [daemon.face.emotion-animation :as animation]
   [daemon.settings :as settings]
   [daemon.smart-atom :as smart-atom]
   [quil.core :as q]
   [quil.middleware :as m]
   [clojure.core.async :as async :refer [go chan <! >!]]
   [clojure.java.shell :as shell]))

(import '[org.opencv.core MatOfInt MatOfByte MatOfRect Mat CvType Size]
        '[org.opencv.imgcodecs Imgcodecs]
        '[org.opencv.imgproc Imgproc]
        '[java.awt Toolkit])


(import 'java.nio.ByteBuffer)
(import 'java.nio.ByteOrder)


(def restore-width (atom (settings/data :width)))
(def restore-height (atom (settings/data :height)))
(def emot-buffer (atom :happy))
(def old-drawn-smart-mat (ref (smart-atom/create (Mat. @(settings/data :width) @(settings/data :height) CvType/CV_8UC3))))
(def transitioner (ref nil))
(def draw-mat? (ref false))
(def smart-mat-to-draw (ref (smart-atom/create (Mat. @(settings/data :width) @(settings/data :height) CvType/CV_8UC3))))
(def in-main-loop? (ref false))
(def cur-emotion (ref nil))

(defn has-extension [the-str ext]
  (> (.indexOf the-str (str "." ext)) -1))

(defn get-ext-filenames [folder ext]
  (filter
   #(has-extension % ext)
   (map
    #(.getName %)
    (filter
     #(.isFile %)
     (.listFiles (clojure.java.io/file folder))))))

(defn turn-gifs-in-folder-into-sprites [folder]
  (let [emotion-names (map
                       #(first (clojure.string/split % #".gif"))
                       (get-ext-filenames folder "gif"))]
    (doall (map #(shell/sh "mkdir" (str folder "/" % )) emotion-names))
    (doall (map #(shell/sh
            "convert"
            "-coalesce"
            (str folder "/" % ".gif")
            (str folder "/" (str % "/%02d.png")))
          emotion-names))))

(def available-emotion-keys 
  (map
   #(keyword (.getName %))
    (filter
     #(not (.isFile %))
     ;;all folders and files
     (.listFiles (clojure.java.io/file (settings/data :face-animation-folder))))))

(defn load-emotions []
  (apply merge (map
    (fn [emot] {emot (animation/new emot)})
    available-emotion-keys)))

(defn setup []
  (q/image-mode :center)
  (q/frame-rate (settings/data :animation-frame-rate))
  (q/background 255)
  (let [animations (load-emotions)]
    (dosync (ref-set cur-emotion :happy))
    {:emotions animations :cur-emotion :happy :cur-frame-no 0 :repl-text "" :keyboard-state {}}))


(defn update-state [state]
  (q/frame-rate @(settings/data :frame-rate))
  (->
   (let [every-x-frame (/ @(settings/data :frame-rate) (settings/data :animation-frame-rate))]
     (if (= (mod (state :cur-frame-no) every-x-frame) 0)
      (if (not (nil? @transitioner))
       ;;transition
       (let [transition-emotion @transitioner]
         (do
           (dosync (ref-set transitioner nil))
           (-> state
               (assoc-in [:emotions transition-emotion]
                         (animation/reset (get-in state [:emotions transition-emotion])))
               (assoc :cur-emotion transition-emotion))))
       ;;or just get the next state
       (assoc-in state
                 [:emotions (state :cur-emotion)]
                 (animation/next-frame (get-in state [:emotions (state :cur-emotion)]))))
      state))
   ;finally assoc in the cur-frame-no
   (assoc :cur-frame-no (mod (+ 1 (state :cur-frame-no)) @(settings/data :frame-rate)))
   (repl/keypress-handler)
   ;;uncomment to clear repl for debugging
   ;;(assoc :repl-text "")
   ))

(defn mat-to-p-image [mat]
  (let [w (.width mat)
        h (.height mat)
        mat2 (Mat.)
        image (q/create-image w h :rgb)
        data8 (make-array Byte/TYPE (* w h 4))
        data32 (int-array (* w h))]
    (. Imgproc cvtColor mat mat2 Imgproc/COLOR_RGB2RGBA)
    (.loadPixels image)
    (.get mat2 0 0 data8)
    (.get (.asIntBuffer (.order (. ByteBuffer wrap data8) ByteOrder/LITTLE_ENDIAN)) data32)
    ;(set! (.-pixels image) data32)
    (System/arraycopy data32 0 (.-pixels image) 0 (count data32))
    (.updatePixels image)
    image))

(defn draw-mat [smart-mat]

  ;;increment the copy counter so the mat doesn't get released mid display
  (smart-atom/copy smart-mat)
  (q/image (mat-to-p-image (smart-atom/deref smart-mat)) 0 700 )

  ;;decrement the copy counter so the mat can get released if the smart-mat-to-draw has been updated
  (smart-atom/delete @old-drawn-smart-mat)
  (dosync (ref-set old-drawn-smart-mat smart-mat)))

(defn update-mat-to-display [smart-mat]
  (try
    (let [new-smart-mat-to-draw
         (if (= (.size (smart-atom/deref smart-mat))
                (Size. @(settings/data :width) @(settings/data :height)))
           ;return a copy of the smart mat if no changes need to be made to the mat
           (smart-atom/copy smart-mat)
           ;;if changes do need to be made, the smart mat must be deep-cloned to get a brand new matrix
           ;;this is because other processes have access to the matrix and we don't want to alter it
           (let [new-smart-mat (smart-atom/deep-clone smart-mat)]
             (Imgproc/resize
                (smart-atom/deref new-smart-mat)
                (smart-atom/deref new-smart-mat)
                (Size. @(settings/data :width) @(settings/data :height)))
             new-smart-mat))]
      ;;decrement the smart mat reference counter
      (smart-atom/delete smart-mat)
      (let [old-smart-mat @smart-mat-to-draw]
        ;;set the new smart-mat-to-draw
        (dosync (ref-set smart-mat-to-draw new-smart-mat-to-draw))
        ;;since the smart-mat-to-draw reference has changed, we need to smart-mat/delete the old smart-mat
        (smart-atom/delete old-smart-mat)))
    (catch Exception e (println (str (.getMessage e))))))

(defn activate-mat-display []
  (dosync (ref-set draw-mat? true)
          (ref-set @(settings/data :frame-rate) 30)))

(defn deactivate-mat-display []
  (dosync (ref-set draw-mat? false)))

(defn calculate-image-numbers []
  (let [w-ratio (/ @(settings/data :width) (settings/data :face-image-width))
        h-ratio (/ @(settings/data :height) (settings/data :face-image-height))
        ratio-dim (if (<= w-ratio  h-ratio) :w :h)
        ratio (min w-ratio h-ratio)
        zoom
        ;;Crazy. I don't know how I should zoom, because of margins.
        ;;I think the function is linear. So I just pick two points
        ;;and choose 2 good looking zooms that look about the same
        (case ratio-dim 
          :w
          (if (< ratio 0.55)
            (+ 1.9 (/ 0.001 ratio))
            (/ 1.0 ratio))
          :h
          (if (< ratio 1)
            (+ 1.1 (/ 0.015 ratio))
            (/ 1.0 ratio)))]

    [(int (/ @(settings/data :width) 2))
     (int (- (/ (* 600 ratio zoom) 2) (if (<= ratio 1) (* 38 ratio) (* 25)) ))
     (int (* 1024 zoom ratio))
     (int (* 600 zoom ratio))]))


(defn draw [state]
  (q/background 0)
  (if @draw-mat?
      (draw-mat @smart-mat-to-draw))
  (apply q/image (animation/get-cur-frame (get-in state [:emotions (state :cur-emotion)]))  (calculate-image-numbers))
  (if (<= 0.1
         (- (/ @(settings/data :height) (settings/data :face-image-height))
            (/ @(settings/data :width) (settings/data :face-image-width))))
    (repl/display state))
  (q/fill 255))

 
;(go (>! "Hello there"))

(defn create []
 (q/defsketch daemon-face
   :size [@(settings/data :width) @(settings/data :height)]
   :features [:resizeable :no-safe-fns :keep-on-top]
   :setup setup
   :update update-state
   :draw draw
   :middleware [m/fun-mode]))




(defn change-emotion
  "Function used to change the emotion displayed of the face. 
   If keyword argument :block is set true, then the function will wait until the animation is in the :emotion-loop to return"
  [emotion & {:keys [block] :or {block false}}]
  (dosync (ref-set in-main-loop? false))
  (if (> (.indexOf available-emotion-keys emotion) -1)
    (dosync (ref-set transitioner emotion)
            (ref-set cur-emotion emotion))
    (throw (Exception. "This emotion is not available")))
  (if block
    (while (not @in-main-loop?))))

(defn get-cur-emotion []
  @cur-emotion)

(defn set-emot-buffer [emot]
  (swap! emot-buffer (constantly emot)))

(defn resize [sketch width height]
  (dosync
   (ref-set (settings/data :width) width)
   (ref-set (settings/data :height) height))
   (.setSize (.frame sketch) width height))

(defn maximize [sketch]
  ;;Cache the old dims for "restore"
  (swap! restore-width (constantly @(settings/data :width)))
  (swap! restore-height (constantly @(settings/data :height)))
  (let [dim (-> (Toolkit/getDefaultToolkit) (.getScreenSize))]
    (resize sketch (.width dim) (- (.height dim) 50))))

(defn restore [sketch]
  (resize sketch @restore-width @restore-height))

(defn add-repl [])

(create)

