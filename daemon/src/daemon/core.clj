(ns daemon.core
  (require [daemon.face.core :as face]
           [daemon.voice.core :as voice]
           [daemon.brochas-area.core :as brochas-area]
           [daemon.prefrontal-cortex.core :as prefrontal-cortex]
           [clj-time.core :as t]
           [clj-time.coerce :as c]
           [overtone.at-at :as at-at]
           [daemon.visual-cortex.youtube-player :as youtube-player]
           [daemon.visual-cortex.core :as visual-cortex]
           [daemon.eyes.core :as eyes]
           [clojure.core.async :as async]
           [daemon.smart-atom :as smart-atom]
           [daemon.keyboard-listener :as keyboard-listener]
           [daemon.prefrontal-cortex.actions :as actions]
           [daemon.temporal-lobe.core :as temporal-lobe]
           [daemon.hippocampus.core])
  (use [clojure.tools.nrepl.server :only (start-server stop-server)]))


(import '[java.util.Timer])

(def user "Collin")


(defn start-greeter []
  (prefrontal-cortex/remove-possible-action :greet)
  (prefrontal-cortex/add-possible-actions
   :greet
   (fn [cur-state] (temporal-lobe/greet user)))
  (visual-cortex/start-face-detect prefrontal-cortex/input))

(defn show-emotions []
  (face/change-emotion :sad)
  (Thread/sleep 1500)
  (face/change-emotion :angry)
  (Thread/sleep 2000)
  (face/change-emotion :nervous)
  (Thread/sleep 2000)
  (face/change-emotion :urgent)
  (Thread/sleep 2000)
  (face/change-emotion :understand)
  (Thread/sleep 2000)
  (face/change-emotion :listen)
  (Thread/sleep 2000)
  (face/change-emotion :happy))


(defn -main []
  (brochas-area/init)
  (eyes/init)
  (visual-cortex/init)
  (actions/add-all)
  (keyboard-listener/start prefrontal-cortex/input)
  (temporal-lobe/init)
  (defonce server (start-server :port 4242)))











