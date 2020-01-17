(ns daemon.voice.watson-speak
  (:require [clojure.edn :as edn :only [read-string]]
            [org.httpkit.client :as http]
            [clojure.java.io :as io]
            [clojure.core.async :as async])
  (:import [com.ibm.watson.developer_cloud.text_to_speech.v1 TextToSpeech]
           [com.ibm.watson.developer_cloud.text_to_speech.v1.util WaveUtils]
           [javax.sound.sampled AudioSystem AudioFormat]
           [java.io
            BufferedInputStream
            InputStream
            ByteArrayInputStream
            FileOutputStream
            FileInputStream]))

(def creds (get (edn/read-string (slurp "config/creds.edn")) :ibm-creds))
(def cache-index (atom (edn/read-string (slurp "resources/watson_voice_cache.edn"))))
(def should-be-cached-next-speak (atom {}))
(def finished (atom true))

(defn instream-to-outstream [in]
  (let [buf (byte-array (* 1024 100))
        out (java.io.ByteArrayOutputStream.)]
    (loop [len (.read in buf)]
      (if (= len -1)
        out
        (do (.write out buf 0 len)
            (recur (.read in buf)))))))

(defn write-byte-array-output-stream-to-file [baos file-name]
   (.writeTo baos (FileOutputStream. file-name)))

(defn cache [phrase stream]
  (let [cache-uuid       (str (java.util.UUID/randomUUID)) 
        cache-file-name  (str "resources/watson_voice_cache/" cache-uuid ".wav")
        out-stream       (instream-to-outstream stream)
        rv               (ByteArrayInputStream. (.toByteArray out-stream))]
    (async/go (write-byte-array-output-stream-to-file out-stream cache-file-name)
              (swap! cache-index assoc phrase cache-uuid)
              (spit "resources/watson_voice_cache.edn" @cache-index))
    rv))


(defn get-synthesis [text]
  (let [options
        {:basic-auth [(creds :username) (creds :password)]
         :query-params {:voice "en-US_AllisonVoice"
                        :accept "audio/wav"
                        :text text}}]
    (WaveUtils/reWriteWaveHeader (@(http/get (str (creds :url) "/v1/synthesize") options) :body))))



(defn is-cached?
  "Takes a phrase and returns a bool indicating if the phrase sound has been cached to disk"
  [phrase]
  (contains? @cache-index phrase))

(defn !add-to-should-be-cached-next-speak
  "Caution: Side Effecty
  Adds phrase to be cached next time it is spoken"
  [phrase]
  (swap! should-be-cached-next-speak assoc phrase true)
  ;;Save to disk so that it is persistent across restarts
  (spit "resources/should-be-cached-next-speak.edn" @should-be-cached-next-speak))

(defn should-be-cached?
  "Should the phrase be cached now?"
  [phrase]
  (and
   (contains? @should-be-cached-next-speak phrase)
   (not (is-cached? phrase))))

(defn load-cache [phrase])

(defn open-wav [stream]
  (let [clip (AudioSystem/getClip)]
      (.open clip (AudioSystem/getAudioInputStream stream))
      clip))

(defn play-wav [clip]
  (.start clip)
  (Thread/sleep 50)
  (while (.isRunning clip) :pass)
  (swap! finished (constantly true)))

(defn open-cached-wav [file-name]
  ;;First open file and convert to input stream
   (open-wav
    (ByteArrayInputStream.
     (org.apache.commons.io.IOUtils/toByteArray (FileInputStream. file-name)))))

(defn speak [text]
    (let [audio-clip
          (if (is-cached? text)
            (open-cached-wav (str "resources/watson_voice_cache/" (@cache-index text) ".wav"))
            (do
              (let [synthesis
                    (if (should-be-cached? text)
                      (cache text (get-synthesis text))
                      (get-synthesis text))]

                (!add-to-should-be-cached-next-speak text)
                (open-wav synthesis))))]
      (swap! finished (constantly false))
      (async/go (play-wav audio-clip))))
















