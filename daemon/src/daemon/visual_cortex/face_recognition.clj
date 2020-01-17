(ns daemon.visual-cortex.face-recognition)

(import '[org.opencv.core MatOfInt MatOfByte MatOfRect Mat CvType Size Scalar Rect]
        '[org.opencv.imgproc Imgproc]
        '[org.opencv.imgcodecs Imgcodecs]
        '[org.opencv.objdetect CascadeClassifier])

(def sees-person (ref false))
(def face-classifier (CascadeClassifier. "/Users/collinbell/opt/opencv/data/haarcascades/haarcascade_frontalface_default.xml"))

(defn detect [mat]
  (let [grey (Mat.)
        faces (MatOfRect.)
        scale 2]
    (. Imgproc cvtColor mat grey Imgproc/COLOR_RGB2GRAY)
    (. Imgproc resize grey grey (Size. (int (/ (.width grey) scale)) (int (/ (.height grey) scale))))
    (.detectMultiScale face-classifier grey faces)
    (.release grey)
    (let [rv
          (filter #(if (> (.-width %1) (/ 150 scale)) true false)
                  (map
                   #(Rect. (* scale (.x %)) (* scale (.y %)) (* scale (.width %)) (* scale (.height %)))
                   (.toArray faces)))]
      (if (> (count rv) 0)
        (dosync (ref-set sees-person true))
        (dosync (ref-set sees-person false)))
      ;;Clean up
      (.release grey)
      rv)))


(defn sees-person? []
  @sees-person)







