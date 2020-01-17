(ns daemon.eyes.core
  (require [daemon.visual-cortex.stream :as vis-stream]
           [daemon.visual-cortex.stream-tree :as stree]
           [daemon.smart-atom :as smart-atom])
  (use [clojure.core.async :only (go)]))


(import '[org.opencv.core MatOfInt MatOfByte MatOfRect Mat CvType Size]
        '[org.opencv.imgcodecs Imgcodecs]
        '[org.opencv.imgproc Imgproc]
        '[org.opencv.videoio VideoCapture Videoio]
        '[org.opencv.objdetect CascadeClassifier])

(import 'java.nio.ByteBuffer)
(import 'java.nio.ByteOrder)
(import 'java.util.concurrent.locks.ReentrantReadWriteLock)

(def gc-freq-in-mins (* 60 2))

(def subscribers (ref []))
(def continue-seeing (ref false))
(def cur-see-thread (atom nil))
(def video-feed (atom nil))
(defn init []
  (def cur-see-thread (atom (Thread. (fn []))))
  (def video-feed (VideoCapture. 0)))

(defn get-field-of-vision []
  [(int (.get video-feed (. Videoio CAP_PROP_FRAME_WIDTH)))
   (int (.get video-feed (. Videoio CAP_PROP_FRAME_HEIGHT)))])


(defn clear-subscribers []
  (dosync (ref-set subscribers [])))

(defn stop-seeing []
  (dosync (ref-set continue-seeing false)))

(defn get-max-fps
  "Warning! This will kill the current eyes stream"
  []
  (stop-seeing)
  (let [start-time
        (. System currentTimeMillis)

        buf
        (Mat.
         (int (.get video-feed (. Videoio CAP_PROP_FRAME_WIDTH)))
         (int (.get video-feed (. Videoio CAP_PROP_FRAME_HEIGHT)))
         CvType/CV_8UC3)]

    (doall (for [x (range 20)]
       (.read video-feed buf)))
    (float (/ 20 (/ (- (. System currentTimeMillis) start-time) 1000)))))


(defn see [stream-tree]
  (print stream-tree)
  (if (or @continue-seeing (.isAlive @cur-see-thread))
    (throw (Exception. "Dameon is already seeing")))
  (dosync (ref-set continue-seeing true))
  (let [time-since-last-gc (ref (. System currentTimeMillis))
        thread
        (Thread.
          (fn []
            (try
             (while @continue-seeing
               (let [buf ;the buffer must be reinstanciated every frame due to it being a Java class
                     (Mat.
                      (int (.get video-feed (. Videoio CAP_PROP_FRAME_WIDTH)))
                      (int (.get video-feed (. Videoio CAP_PROP_FRAME_HEIGHT)))
                      CvType/CV_8UC3)]

                 (.read video-feed buf)
                 (if (= 0 (count (stree/get-roots @stream-tree)))
                   (.release buf)
                   (doall
                    (map #(go (vis-stream/update-mat
                               %
                               (smart-atom/create buf)
                               (. System currentTimeMillis)))
                         (stree/get-roots @stream-tree))))
                 (if (> (. System currentTimeMillis) (+ @time-since-last-gc (* 1000 60 gc-freq-in-mins)))
                   (do
                     (. System gc)
                     (dosync (ref-set time-since-last-gc (. System currentTimeMillis)))))))
             (catch Exception e (do (println (str e "\n" )) (stop-seeing))))))]
    (.start thread)
    (swap! cur-see-thread (fn [a] identity thread))
    thread))










