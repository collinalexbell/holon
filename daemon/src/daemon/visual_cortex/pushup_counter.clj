(ns daemon.visual-cortex.pushup-counter
  (:require
   [daemon.smart-atom :as smart-atom]
   [daemon.voice.core :as voice]
   [clojure.math.numeric-tower :as math])
  (:import org.httpkit.BytesInputStream
           [org.opencv.core MatOfByte Core Mat Point Scalar]
           [org.opencv.imgcodecs Imgcodecs]
           [org.opencv.imgproc Imgproc]
           [org.opencv.video Video])
  ;(:use [incanter core stats charts io])
  )

(def plot nil)
(def pushup-plot nil)
(def last-pushup-time (atom 99999999999999999))
(def already-bitched (atom false))
(def maximum-break 3200) ;in ms
(def pushup-count (atom 0))
(def last-frames (atom []))
(def last-frame (atom nil))
(def frame-history-size 3)
(def test-frame (atom nil))
(def test-exception (atom nil))
(def fgbg  nil)

(defn add-frame [frame]
  (try (if (= (count @last-frames) frame-history-size)
     (do
       (smart-atom/delete (peek @last-frames))
       (swap! last-frames pop)))
       (catch Exception e (def except (.getMessage e))))
  (swap! last-frames (fn [lf] (into [] (cons frame lf)))))

(def last-centroid (atom nil))
(def last-dydx (atom nil))
(def centroid-extream (atom nil))
(def movement-threshold 120)

(defn get-centroid-dydx [new-centroid]
  (if @last-centroid
    (- (new-centroid :y) (@last-centroid :y))
    nil))

(defn get-centroid [mat]
  (let [moments (Imgproc/moments mat)]
    {:x (/ (.get_m10 moments) (.get_m00 moments))
     :y (/ (.get_m01 moments) (.get_m00 moments))}))

(defn experienced-v-sign-flip? [new-centroid new-dydx]
  (if (and
       ;;centroids and derivatives already must exist
       @last-centroid @last-dydx
       ;;test diffent signs (aka passed through 0 derivitave)
       (<= (* @last-dydx new-dydx) 0.1))
    true
    false))

(defn experienced-pushup? [new-centroid new-dydx]
  (if (and
       @centroid-extream
       (experienced-v-sign-flip? new-centroid new-dydx)
       (< @last-dydx 0)
       (> (math/abs (- @centroid-extream (new-centroid :y))) movement-threshold))
    true
    false))

(defn handle-pushup-experience []
  ;(add-points pushup-plot [(System/currentTimeMillis)] [1])
  (swap! pushup-count + 1)
  (swap! last-pushup-time (fn [ignore] (System/currentTimeMillis)))
  (swap! already-bitched (constantly false))
  (voice/speak @pushup-count))

(defn handle-too-long-of-break []
  (voice/speak "You are taking too long of a break"))

(defn get-motion [new-frame]
  (swap! last-frame (constantly (smart-atom/deref new-frame)))
  (let [rv (Mat.)]
    (try
      (.apply fgbg (smart-atom/deref new-frame) rv)
      (catch Exception e (do (println "exception")
                             (swap! test-exception (constantly (.getMessage e))))))
    (let [centroid (get-centroid rv)
          dydx     (get-centroid-dydx centroid)]
      (try
        (Imgproc/rectangle (smart-atom/deref new-frame) (Point. 20 20) (Point. 160 100) (Scalar. 255.0 255.0 255.0) -1)
        (Imgproc/putText (smart-atom/deref new-frame) (str @pushup-count)
                         (if (> @pushup-count 9)
                           (Point. 65 73)
                           (Point. 75 73))
                         Core/FONT_HERSHEY_PLAIN 3 (Scalar. 0.0) 2)

        ;(add-points plot [(System/currentTimeMillis)] (centroid :y))
        (if (and
             (not @already-bitched)
             (> @pushup-count 0)
             (> (-  (System/currentTimeMillis) @last-pushup-time) maximum-break))
          (do
            (swap! already-bitched (constantly true))
            (handle-too-long-of-break)
            ))
        (if (experienced-pushup? centroid dydx)
          (handle-pushup-experience))
        (if (experienced-v-sign-flip? centroid dydx)
          ;;we need to make sure that the extreams are greater than a threshold
          ;;this prevents small dydx sign flips from causing problems
          (swap! centroid-extream (constantly (centroid :y))))
        (swap! last-centroid (constantly centroid))
        (swap! last-dydx (constantly dydx))
        (catch Exception e  (println (.getMethodName (.getStackTrace e)))))
      (.release rv)
      {:smart-mat new-frame})))

(defn init []
  (swap! pushup-count (constantly 0))
  ;(def plot (time-series-plot [] []))
  ;(def pushup-plot (time-series-plot [] []))
  (def fgbg  (Video/createBackgroundSubtractorMOG2))
  (.setHistory fgbg 50))


















