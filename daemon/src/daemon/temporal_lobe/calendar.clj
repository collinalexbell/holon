(ns daemon.temporal-lobe.calendar
  (:require [clojure.edn :as edn :only [read-string]]
            [clojure.pprint :as pprint]
            [clojure.data.json :as json]
            [clj-time.core :as t]
            [clj-time.format :as f]
            [clj-time.local :as l]
            [clj-time.coerce :as c])


  (:use [google-apps-clj.google-calendar]))

(def creds (edn/read-string (slurp "config/google-creds.edn")))


(def google-datetime-formatter (f/formatter "yyyy-MM-dd'T'hh:mm:ssZZ"))

(defn get-todays-events
  []
  (list-events creds
               (f/unparse google-datetime-formatter (t/today-at 00 00))
               (f/unparse google-datetime-formatter (t/plus (t/today-at 23 59) (t/days 1)))))


(defn get-hour [date-time] (f/unparse (f/formatter "h:mm") date-time))


(defn events-to-strings
  [events]
  (map #(str
         (.getSummary %)
         (let  [date-time (.getDateTime (.getStart %))]
           (if (not (nil? date-time))
             (let [date-time (c/from-long (.getValue date-time))]
               (str " at " (get-hour date-time) " "))
             " at anne unknown time "))
         )events))

(defn list-to-string-with-and [list]
  (apply str
   (let [list-without-and (into [] (rest (interleave (repeat ", ") list)))]
     (if (> (count list-without-and) 1)
       (conj (into [] (butlast (butlast list-without-and))) ", and " (last list-without-and))))))

(defn event-list-to-string [event-list time-period-text]
  (str "You have " (count event-list) " events " time-period-text ". "
       (list-to-string-with-and (events-to-strings event-list))))

















