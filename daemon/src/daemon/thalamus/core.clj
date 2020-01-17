(ns daemon.thalamus.core
  (:require [daemon.face.core :as face]
            [daemon.eyes.core :as eyes]
            [daemon.visual-cortex.core :as visual-cortex]
            [daemon.brochas-area.core :as brochas-area]
            [clojure.core.async :as async])) 

(defn init-face []
  (face/create))

(defn init-eyes []
  (eyes/see visual-cortex/tree))

(defn init-brochas-area []
  (brochas-area/launch-sphinx))


(defn wake-up []
  (async/go (init-face))
  (async/go (init-eyes))
  (async/go (init-brochas-area)))
