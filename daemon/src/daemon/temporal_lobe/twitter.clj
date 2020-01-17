(ns daemon.temporal-lobe.twitter
  (:import [twitter4j TwitterStreamFactory StatusListener StreamListener Status UserStreamListener TwitterFactory StatusUpdate]
           [twitter4j.conf ConfigurationBuilder])
  (:require [clojure.edn :as edn :only [read-string]]))



;;The class that handles the stream data
(def current-listener-code
  (atom
   '(proxy [UserStreamListener] []
      (onStatus [status])
      (onFollow [src followed])
      (onDeletionNotice [status-deletion-notice] (+ 1 1))
      (onTrackLimitationNotice [number-of-limited-statuses] (+ 1 1))
      (onStallWarning [warning] (+ 1 1))
      (onException [ex]
        (.printStackTrace ex))
      (onScrubGeo [user-id up-to-status-id] (+ 1 1))
      (onDirectMessage [msg]
        (spit "foo" {:sender (.getSenderScreenName msg)
                     :createdAt (.getCreatedAt msg)
                     :recipient (.getRecipientScreenName msg)
                     :text (.getText msg)})))))


;;Connect to the stream and add listener
(def creds (get (edn/read-string (slurp "config/creds.edn")) :twitter))
(def config 
  (-> (ConfigurationBuilder.)
     (.setDebugEnabled true)
     (.setOAuthConsumerKey (creds :consumer-key))
     (.setOAuthConsumerSecret (creds :consumer-secret))
     (.setOAuthAccessToken  (creds :access-token))
     (.setOAuthAccessTokenSecret (creds :access-secret))
     (.build)))

(def t-stream
  (-> config
   (TwitterStreamFactory.)
   (.getInstance)))

(def t
  (-> config
      (TwitterFactory.)
      (.getInstance)))

(defn tweet [the-tweet]
  (.updateStatus t (StatusUpdate.
                    (if (<= (count the-tweet) 126)
                      (str the-tweet "~sent by my AI.")
                      the-tweet))))



(defn kill []
    (.cleanUp t-stream))

(defn notify-me-if [person action]
  ())

(defn print-diagnostic
  "Will return the username if twitter is correctly loaded"
  []
  (println (.getScreenName t-stream)))
















