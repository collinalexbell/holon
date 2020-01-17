(ns daemon.temporal-lobe.wiki-search
  (:require [org.httpkit.client :as http]
            [clojure.edn :as edn :only [read-string]]
            [clojure.data.json :as json])
  (:import [javafx.application Application]
           [javafx.scene Scene]
           [javafx.scene.web WebView]
           [javafx.stage StageBuilder]))


(def viewer nil)
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

(defn view [url]
 (if (= nil viewer)
   (let [stage-data
         (run-now
          (let [inner-stage (.build (StageBuilder/create))
                web-view (WebView.)]
            (-> web-view 
                (.getEngine)
                (.load url))
            (.setPrefSize web-view 640 390)
            (.setScene inner-stage (Scene. web-view))
            {:inner-stage inner-stage :web-view web-view}))]
     (run-now (.show (stage-data :inner-stage)))
     stage-data)
   (do (run-now (.load (.getEngine (viewer :web-view)) url))
       (run-now (.show (viewer :inner-stage)))
       viewer)))

(defn http-search [term]
  (let [options
        {:query-params
         {:action "opensearch"
          :search term
          :limit 1
          :namespace 0
          :format "json"}}]
    (http/get "https://en.wikipedia.org/w/api.php" options)))


(defn search [term]
  (->  @(http-search term)
       (get :body)
       (json/read-str)
       ;;get to the urls
       (last)
       ;;get the first url
       (first)
       ;;load into browser
       (view)))








