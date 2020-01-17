(ns daemon.keyboard-listener
  (:require
   [clojure.core.async :as async]
   [clojure.java.shell :as shell]
   [daemon.voice.core :as voice]))



(defn start-hotkey-daemon []
  (async/go (shell/sh "libs/hotkey/bin/hotkey.sh")))


(defn gen-hotkey-listener [callback]
  (fn [line]
    (println "hotkey event")
    (let [data (read-string line)]
        (async/go (callback data)))))

(defn readFile [file listener]
  (with-open [rdr (clojure.java.io/reader file)]
    (doseq [line (line-seq rdr)]
      (listener line))))

(defn launch-hotkey-listener [callback]
  (async/go
    (readFile
    (str (System/getProperty "user.dir") "/libs/hotkey/pipe")
    (gen-hotkey-listener callback))))


(defn kill-daemon []
  (doall
   (map #(shell/sh "kill" "-9" %)
        (clojure.string/split
         (get (shell/sh "libs/hotkey/bin/get_pid.sh") :out)
         #"\n"))))



(defn start [callback]
  (start-hotkey-daemon)
  (launch-hotkey-listener callback))















