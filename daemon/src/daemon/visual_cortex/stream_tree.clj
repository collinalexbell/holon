(ns daemon.visual-cortex.stream-tree)

(defn remove-from-vec [a index]
  (vec (concat (subvec a 0 index) (subvec a (+ index 1)))))

(defn dissoc-in
  "Dissociates an entry from a nested associative structure returning a new
  nested structure. keys is a sequence of keys. Any empty maps that result
  will not be present in the new structure."
  [m keys]
  ;;using ex (dissoc-in {:foo {:bar [:baz :bot]}} [:foo :bar 0])
  (let [container
        ;;[:baz :bot]
        (get-in m
                ;; [:foo :bar]
                (butlast keys))]

    (assoc-in
     m (butlast keys)
     (if (= (type {}) (type container))
       (dissoc container (last keys))
       (remove-from-vec (into [] container) (last keys))))))


(defn create []
  {:paths {} :structure []})

(defn get-in-
  "get-in which assumes structure stored in :upstreams key so that path can be a vec of indicies"
  [upstreams path]
  (let [remaining (rest path)
        cur-stream (if (nil? (first path))
                    {:up-streams upstreams}
                    (get upstreams (first path) nil))]
    (if (or (empty? remaining) (nil? cur-stream))
      cur-stream
      (get-in- (get cur-stream :up-streams) remaining))))

(defn add
  "Add stream to tree at index"
  [tree stream & [parent-name]]
  (let [path
        (if (nil? parent-name)
          []
          (get-in tree [:paths parent-name]))

        parent-upstreams
        (get (get-in- (tree :structure) path) :up-streams)]

    (if (nil? path) (throw (Exception. "This parent doesn't exist")))
    (if (nil? (get stream :name)) (throw (Exception. "This stream doesn't have a name")))
   (-> tree

       (assoc-in
        (concat [:structure] (interleave path (repeat :up-streams)))
        (conj parent-upstreams stream))

       (assoc-in
        [:paths (get stream :name)] 
        (conj path (count parent-upstreams))))))


(defn get
  "Fetches the stream from the tree with the given name"
  [tree stream-name]
  (let [path (get-in tree [:paths stream-name] nil)]
    (if (nil? path) 
      nil
      (get-in- (tree :structure) path))))


(defn remove-path-from-paths-
  [tree p]
  (assoc tree :paths
         (into
          {}
          (filter
           (comp not nil?)
           (map (fn [path]
                  (let [ind-pos (- (count p) 1)
                        ;;ex
                        ;;[0 2] => 2
                        ind-to-del (last p)
                        ;;[0 3 0] => 3
                        ind-to-test (nth (last path) ind-pos -1)]
                    (cond
                      (> ind-to-test ind-to-del)
                      {(first path) (assoc (last path) ind-pos (- (nth (last path) ind-pos) 1))}

                      (= ind-to-test ind-to-del)
                      nil

                      :else
                      path)))
                (tree :paths))))))


(defn delete
  "Removes the stream from the tree with the given name."
  [tree stream-name]
  (let [path (get-in tree [:paths stream-name])]
    ;;return the new tree
    (-> tree
        (remove-path-from-paths- path)
        (dissoc-in (concat [:structure ]
                             ;; [:structure 0 ..]
                             [(first path)]
                             ;; [:structure 0 :up-streams 0 ...]
                             (interleave (repeat :up-streams) (rest path)))))))


(defn get-roots [tree]
  (tree :structure))
