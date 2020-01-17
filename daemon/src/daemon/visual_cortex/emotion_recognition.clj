(ns daemon.visual-cortex.emotion-recognition
  (:require [org.httpkit.client :as http]
            [clojure.edn :as edn :only [read-string]]
            [clojure.data.json :as json])
  (:import org.httpkit.BytesInputStream
           [org.opencv.core MatOfByte]
           [org.opencv.imgcodecs Imgcodecs]))

(def creds (get (edn/read-string (slurp "config/creds.edn")) :microsoft-emotion))

(defn mat-to-png-bytes [mat]
  (let [img-buf (MatOfByte.)]
    (Imgcodecs/imencode ".png" mat img-buf)
    (let [rv (.toArray img-buf)]
      (doto (java.io.FileOutputStream. "wtf.png")
        (.write rv)
        (.close))
      rv)))

(defn call-api [png-bytes]
  (let [options
        {:headers {"Ocp-Apim-Subscription-Key" (creds :key) 
                   "Content-type" "application/octet-stream"}
         :body (BytesInputStream. png-bytes (count png-bytes))}]
    (http/post "https://api.projectoxford.ai/emotion/v1.0/recognize" options)))

(defn parse-emotion-response [response]
   (json/read-str (response :body) :key-fn keyword))

(defn go [mat]
  (parse-emotion-response
   @(call-api (mat-to-png-bytes mat))))

(defn get-emotion-with-highest-confidence [emotion-response]
  (first
   (reduce
    #(if (< (second %1) (second %2)) %2 %1)
    ((first emotion-response) :scores))))



















