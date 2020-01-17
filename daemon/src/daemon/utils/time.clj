(ns daemon.utils.time)

(defn parse-time-string-into-ms
  "Will convert time strings of the forms ss or mm:ss or hh:mm:ss or dd:hh:mm:ss"
  [time-string]
  ;;Count the colons, that will tell you what the first numbers should be
  (apply
   +
   (map
    #(* (Integer/parseInt %1)  %2)
    (reverse (clojure.string/split time-string #":")) 
    [1000 (* 1000 60) (* 1000 60 60) (* 1000 60 60 24)])))

