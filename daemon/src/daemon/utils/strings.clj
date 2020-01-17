(ns daemon.utils.strings)

(defn parse-int
  ""
  [s]
   (Integer. (re-find  #"\d+" s )))

