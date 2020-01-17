(ns daemon.brochas-area.analyzer
  (:use [incanter core stats charts io]))


(defn slurp-bytes
  "Slurp the bytes from a slurpable thing"
  [x]
  (with-open [out (java.io.ByteArrayOutputStream.)]
    (clojure.java.io/copy (clojure.java.io/input-stream x) out)
    (.toByteArray out)))



(def demo-recording (slurp-bytes "resources/demo.wav"))


(def plot (xy-plot
           (range)
           (subvec
            (into [] (take 650000
                            (map
                             #(- (bit-and (int %) 0xff) 0x7f)
                            demo-recording)))
             50000 55000)))

(defn view-audio-plot [audio-data start-index stop-index]
  (-> (xy-plot
       (range)
       (subvec
        (into [] (take 650000
                       (map
                        #(- (bit-and (int %) 0xff) 0x7f)
                        audio-data)))
        start-index stop-index))
      (view)))

(count demo-recording)

(set-point-size plot 1)
(view plot)












