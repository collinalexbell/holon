(ns daemon.visual-cortex.visualizer
  (:require
   [quil.core :as q]
   [daemon.smart-atom :as smart-atom]))

(import '[org.opencv.core Size Mat CvType]
        '[org.opencv.imgproc Imgproc]
        'java.nio.ByteOrder
        'java.nio.ByteBuffer)


(def w 640)
(def h 360)


(def old-drawn-smart-mat (ref (smart-atom/create (Mat. w h CvType/CV_8UC3))))
(def smart-mat-to-draw (ref (smart-atom/create (Mat. w h CvType/CV_8UC3))))

(defn update-mat-to-display [smart-mat]
  (try
    (let [new-smart-mat-to-draw
         (if (= (.size (smart-atom/deref smart-mat))
                (Size. w h))
           ;return a copy of the smart mat if no changes need to be made to the mat
           (smart-atom/copy smart-mat)
           ;;if changes do need to be made, the smart mat must be deep-cloned to get a brand new matrix
           ;;this is because other processes have access to the matrix and we don't want to alter it
           (let [new-smart-mat (smart-atom/deep-clone smart-mat)]
             (Imgproc/resize
                (smart-atom/deref new-smart-mat)
                (smart-atom/deref new-smart-mat)
                (Size. w h))
             new-smart-mat))]
      ;;decrement the smart mat reference counter
      (smart-atom/delete smart-mat)
      (let [old-smart-mat @smart-mat-to-draw]
        ;;set the new smart-mat-to-draw
        (dosync (ref-set smart-mat-to-draw new-smart-mat-to-draw))
        ;;since the smart-mat-to-draw reference has changed, we need to smart-mat/delete the old smart-mat
        (smart-atom/delete old-smart-mat)))
    (catch Exception e (println (str (.getMessage e))))))

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
  (q/image (mat-to-p-image (smart-atom/deref smart-mat)) 0 0)

  ;;decrement the copy counter so the mat can get released if the smart-mat-to-draw has been updated
  (smart-atom/delete @old-drawn-smart-mat)
  (dosync (ref-set old-drawn-smart-mat smart-mat)))


(defn draw []
    (draw-mat @smart-mat-to-draw))
 
(defn setup [])

(defn create []
  (q/defsketch viz
    :size [640 360]
   :features [:no-safe-fns]
    :setup setup
    :draw  draw))


















