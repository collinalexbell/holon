(ns daemon.prefrontal-cortex.actions
  (:require
   [daemon.face.core :as face]
   [daemon.voice.core :as voice]
   [daemon.brochas-area.core :as brochas-area]
   [daemon.prefrontal-cortex.core :as pfc]
   [daemon.visual-cortex.youtube-player :as youtube-player]
   [daemon.temporal-lobe.calendar :as cal]
   [daemon.visual-cortex.core :as visual-cortex]
   [daemon.temporal-lobe.core :as temporal-lobe]
   [daemon.temporal-lobe.twitter :as twitter]))


(def action-map
  {:listen-intently
    (fn [cur-state]
      (face/set-emot-buffer (face/get-cur-emotion))
      (face/change-emotion :listen)
      (if (not (@temporal-lobe/state :anticipate-vocal-input))
        (voice/speak "I am listening"))
      (if (= (cur-state :event) :combo-pressed)
        ;;-1 activates manual stoppage
        (brochas-area/record-and-interpret-speech -1 pfc/input)
        (brochas-area/record-and-interpret-speech 5000 pfc/input)))

   :act-on-speech
   (fn [cur-state]
     (temporal-lobe/act-on-speech cur-state))

   :tell-me-todays-events
   (fn [cur-state]
     (voice/speak (cal/event-list-to-string (cal/get-todays-events) "today")))

   :stop-listening
   (fn [cur-state]
     (@brochas-area/stop-listening))

   :face-detection
   (fn [cur-state]
     (if (> (get-in cur-state [:data :conseq-face-frames]) 1)
       (do (swap! visual-cortex/detect-face (constantly nil)) 
           (pfc/do-best-action cur-state :greet))))

   :update-user-status
   temporal-lobe/update-user-status

   :count-pushups
   (fn [cur-state]
     (voice/speak "Ok.")
     (visual-cortex/display-pushup-counter (cur-state :num-pushups)))})

(defn add-all []
  (doall
   (map
    #(apply pfc/add-possible-actions %)
    action-map)))


(defn reload-action [action]
  (pfc/remove-possible-action action)
  (pfc/add-possible-actions action (action-map action)))


















