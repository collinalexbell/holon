(ns daemon.utils.coll)

(defn index-of [item coll]
  "Finds item in list. Returns index or -1 if not found"
  (let [index (count (take-while (partial not= item) coll))]
    (if (not (= index (count coll)))
      ;;found
      index
      ;;not found
      -1)))

