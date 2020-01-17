(ns daemon.temporal-lobe.interrupt
  (:require
   [clojure.core.async :as async]
   [overtone.at-at :as at-at]
   [daemon.voice.core :as voice]
   [clj-time.coerce :as c]
   [clj-time.format :as f]))

(def list-limit 5)
(def interrupts (at-at/mk-pool))



(defn parse-time-string-into-ms [time-string]
  ;;Count the colons, that will tell you what the first numbers should be
  (apply
   +
   (map
    #(* (Integer/parseInt %1)  %2)
    (reverse (clojure.string/split time-string #":")) 
    [1000 (* 1000 60) (* 1000 60 60) (* 1000 60 60 24)])))

(defn add-interrupt
  [interrupt-time desc & actions]
  (at-at/after
   (if (string? interrupt-time)
     (parse-time-string-into-ms interrupt-time)
     interrupt-time)
   #(doall
     (map
      (fn [action] (action))
      actions))
   interrupts
   :desc desc))

(defmacro parse-fire-interrupt-symbols
  [m s]
  `(apply assoc-in
          ~m
         (case (name (first ~s))
           "in"
           `([:time] ~(second ~s))
           "named"
           `([:desc :name] ~(second ~s))
           "that-says"
           `([:actions]
             ~(conj
               (get ~m :actions [])
               `(fn [] (voice/speak ~(second ~s)))))
           "then-waits"
           `([:actions]
             ~(conj
               (get ~m :actions [])
               `(fn [] (Thread/sleep (parse-time-string-into-ms
                                      ~(second ~s))))))
           "then-says"
           `([:actions]
             ~(conj
               (get ~m :actions [])
               `(fn [] (voice/speak ~(second ~s))))))))

(let [a {}
      b [(symbol "then-waits") "20"]]
 (parse-fire-interrupt-symbols a b))


(defmacro fire-interrupt*
  "Example Usage:

  (fire-interupt*
    named \"hello & goodby\"
    in \"2:00\" 
    ;; at \"3:00\" (in means timer and at means alarm)
    that-says \"Hello World\" 
    then-waits \"00:02\" 
    then-says \"Goodby World\") "


  [& stuff]
  (let
      [data
       (let [s (partition 2 stuff)]
         (reduce
          (fn [a b] (parse-fire-interrupt-symbols a b)) 
          {}
          s))]
    `(apply add-interrupt ~(data :time) ~(data :desc) ~(data :actions))))



;;;example speech
;;; "set timer for 2 minutes in category awesome that says hello world then waits 2 seconds and then says goodbye world"

(defn k->s [k]
  (name k))

(defn to-str [i]
  (str
   "<speak version=\"1.0\">"
   "interrupt i.d. " (get i :id) 
   (if-let [name (get-in i [:desc :name])]
     (str " <break strength=\"x-weak\"></break>with name " (k->s name)))
   " <break strength=\"x-weak\"></break> firing at "
   (f/unparse (f/formatters :hour-minute)
              (c/from-long (+ (get i :created-at) (get i :initial-delay))))
   "</speak>"))

(defn get-interrupts-by-id-set [id-set]
  (filter
   #(if (empty? id-set)
      true
      (contains? id-set (get % :id)))
      (at-at/scheduled-jobs interrupts)))

(defn is-are [count]
  (if (= count 1)
    "is"
    "are"))

(defn plural-or-not [count]
  (if (= count 1)
    ""
    "s"))

(defn gen-interupt-speak-intro [cnt]
  (str "There "
       (is-are cnt)
       " "
       cnt
       " interrupt" (plural-or-not cnt) ":"))

(defn speak-interrupts [id-set]
  {:pre  [(set? id-set)]}
  (let [filtered-interrupts (get-interrupts-by-id-set id-set)]
   (println
    (reduce
     #(str (if (not (= (gen-interupt-speak-intro (count filtered-interrupts)) %1))
             (str %1 " and ") %1)
           (to-str %2) " ")
     (gen-interupt-speak-intro (count filtered-interrupts))
     filtered-interrupts))))

(defn delete-interupts [id-set]
  (run!
   #(at-at/kill %)
   (get-interrupts-by-id-set id-set)))











