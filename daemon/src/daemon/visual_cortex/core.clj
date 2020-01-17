(ns daemon.visual-cortex.core
  (require [daemon.eyes.core :as eyes]
           ;;[daemon.face.core :as face]
           [daemon.visual-cortex.stream :as stream]
           [daemon.visual-cortex.stream-tree :as stree]
           [daemon.visual-cortex.emotion-recognition :as emotion-recognition]
           ;;[daemon.visual-cortex.youtube-player :as youtube]
           ;;[daemon.visual-cortex.visualizer :as visualizer]
           [daemon.smart-atom :as smart-atom]
           [daemon.voice.core :as voice]
           [clojure.core.async :as async]
           [daemon.visual-cortex.pushup-counter :as pushup])
  (import [com.atul.JavaOpenCV Imshow]))




(import '[org.opencv.core MatOfInt MatOfByte MatOfRect Mat CvType Size Scalar Rect]
        '[org.opencv.imgproc Imgproc]
        '[org.opencv.imgcodecs Imgcodecs]
        '[org.opencv.objdetect CascadeClassifier])


(def saw-face-last-frame (atom false))
(def conseq-face-count (atom 0))
(def tree (atom (stree/create)))
(def detect-face (atom nil))
(def recognize-emotion (atom nil))
(def stream-on-face-running (ref false))
(def imshow nil)


(defn init []
  (def imshow (Imshow. "Dameon Sight"))
  (eyes/see tree))

(defn remove-stream-on-face []
  (dosync (ref-set stream-on-face-running false))
  ;;(face/deactivate-mat-display)
  )

(defn display-basic-vision []
  (swap! tree stree/add
         (->> (stream/->Base-stream []
                                    [#(do
                                        (spit "display-basic-vision.log" (str % "\n") :append true)
                                        ;;(visualizer/update-mat-to-display (% :smart-mat))
                                        )]
                                    :base-stream)
          (stream/set-fps 20))))

(defn start-face-detect [input-fn]
  (swap! detect-face (constantly true))
  (swap! tree stree/add
         (->>
          (stream/->FaceDetectionStream
           []
           [#(try
               (spit "display-basic-vision.log" (str % "\n"))
               (smart-atom/delete (% :smart-mat))
               (if (and
                    (not (nil? @detect-face))
                    (> (count (% :faces)) 0))
                 (do
                   (swap! conseq-face-count (fn [count] (+ count 1)))
                   (input-fn {:event :face-detection
                              :data  {:faces (% :faces) :conseq-face-frames @conseq-face-count}})

                   )
                 (do (swap! conseq-face-count (constantly 0))))
               (catch Exception e (spit "exceptions.log" (str (.getMessage e) "\n" :append true))))]
           :face-stream)
          (stream/set-fps 0.5))))

(def emotion-recognition-to-ai-emotion-map
  {:anger :angry
   :sadness :cry
   :happiness :happy
   :fear :nervous
   :suprise :nervous
   :contempt :anger
   :neutral :understand})

(defn handle-emotion-response [emotion-response]
  (println emotion-response)
   (let [emotion
         (emotion-recognition-to-ai-emotion-map
          (emotion-recognition/get-emotion-with-highest-confidence emotion-response))]
     ;;(face/change-emotion emotion)
     (if (= emotion :sadness) :pass)))

(defn send-frame-to-emotion-recognition []
  (swap! tree stree/add
         (->> (stream/->Base-stream
               []
               [(fn [data]
                  (try
                   (if (not (nil? @recognize-emotion))
                     (do
                       (swap! recognize-emotion (constantly nil))
                       (handle-emotion-response
                        (emotion-recognition/go (smart-atom/deref (data :smart-mat))))
                       (println "running")))
                   (catch Exception e (println (.getMessage e)))))]
               :emotion-stream)
              (stream/set-fps 4))))


(defn stop-display-basic-vision []
  ;;(face/deactivate-mat-display)
  (swap! tree (fn [ignore] (stree/create))))

(def prev-smart-mat (atom (smart-atom/create (Mat.))))

(defn display-pushup-counter [stop-at-num]
  (stop-display-basic-vision)
  (pushup/init)
  (swap! tree stree/add
         (->> (stream/->PushupDetectionStream
               []
               [#(let [img (smart-atom/deref (% :smart-mat))]
                   (let [old-smart-mat @prev-smart-mat]
                     (swap! prev-smart-mat (constantly (smart-atom/copy (% :smart-mat))))
                     (smart-atom/delete old-smart-mat))
                   ;(Imgcodecs/imwrite "out.jpg" img)
                   (.showImage imshow img)
                   (if (>= @pushup/pushup-count stop-at-num)
                     (do
                       (stop-display-basic-vision)
                       (Thread/sleep 800)
                       (voice/speak "You have finished your workout, would you like me to log that for you?"))))]
               :pushup-counter)
              (stream/set-fps 10))))

















