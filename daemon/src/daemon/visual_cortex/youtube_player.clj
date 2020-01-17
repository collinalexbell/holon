(ns daemon.visual-cortex.youtube-player
  (:require [org.httpkit.client :as http]
            [clojure.edn :as edn :only [read-string]]
            [clojure.data.json :as json])
  (:import [javafx.application Application]
           [javafx.scene Scene]
           [javafx.scene.web WebView]
           [javafx.stage StageBuilder]))


(def player nil)
(defonce force-toolkit-init (javafx.embed.swing.JFXPanel.))
;;Do not close if window is hidden
(javafx.application.Platform/setImplicitExit false)
 
(defn run-later*
[f]
(javafx.application.Platform/runLater f))
 
(defmacro run-later
[& body]
`(run-later* (fn [] ~@body)))
 
(defn run-now*
[f]
(let [result (promise)]
  (run-later
   (deliver result (try (f) (catch Throwable e e))))
  @result))
 
(defmacro run-now
[& body]
`(run-now* (fn [] ~@body)))


(def creds ((edn/read-string (slurp "config/creds.edn")) :youtube))

(defn search-request [term-string]
  (let [options
        {:query-params {:part "id" 
                        :key  (creds :key)
                        :q     term-string
                        :type  "video"}}]
    (http/get "https://www.googleapis.com/youtube/v3/search" options)))

(defn parse-response [response]
  (json/read-str (response :body) :key-fn keyword))

(defn statistics-request 
  "Accepts a map of video ids and calls the api to get statistics"
  [ids]
  (let [options
        {:query-params
         {:part "statistics, snippet"
          :id (clojure.string/join "," ids)
          :key (creds :key)}}] 
    (http/get "https://www.googleapis.com/youtube/v3/videos" options)))

(defn get-data-from-search
  [search-items]
  ((parse-response
    @(statistics-request
      (map #(get-in % [:id :videoId]) search-items)))
   :items))

(defn sort-fn [a b]
  (>
   (Integer. (get-in a [:statistics :viewCount]))
   (Integer. (get-in b [:statistics :viewCount]))
   true
   false))

(defn search [term-string]
  (sort-by #(get-in % [:statistics :viewCount] 0)
        (get-data-from-search
         ((parse-response
           @(search-request term-string))
          :items))))

(defn get-url [media]
  (if (= media :chopin)
    "https://www.youtube.com/watch?v=9E6b3swbnWg"
    media))

(defn play [media]
  (if (= nil player)
   (let [video-url (get-url media)
         stage-data
         (run-now
          (let [inner-stage (.build (StageBuilder/create))
                web-view (WebView.)]
            (-> web-view 
                (.getEngine)
                (.load video-url))
            (.setPrefSize web-view 640 390)
            (.setScene inner-stage (Scene. web-view))
            {:inner-stage inner-stage :web-view web-view}))]
     (run-now (.show (stage-data :inner-stage)))
     stage-data)
   (do (run-now (.load (.getEngine (player :web-view)) media))
       (run-now (.show (player :inner-stage)))
       player)))

(defn play-most-popular-by-search-term [search-term]
  (def player
    (play (str "https://www.youtube.com/watch?v="
              (get-in
               (first ((parse-response @(search-request search-term)) :items))
               [:id :videoId])))))

(defn stop-player []
  (def player (play "about:blank"))
  (run-now (.hide (player :inner-stage))))




















