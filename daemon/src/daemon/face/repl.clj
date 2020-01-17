(ns daemon.face.repl
  (:require
   [daemon.settings :as settings]
   [quil.core :as q]))

(def key-delay-in-ms 30)
(def double-tap-delay-in-ms 120)

(defn cursor-handler [state]
 (if (> (state :cur-frame-no) (/ @(settings/data :frame-rate) 2)) 
   "|"
   ""))

(defn display [state]
  (q/text
   ;;text to display
   (str (if (not (nil? (state :repl-output))) (str ">> " (state :repl-output) "\n") "\n")
        ">> "
        (state :repl-text)
        (cursor-handler state))

   ;;position
   15                             
   (- @(settings/data :height) 30)))     

(defn ready-to-accept-new-key? [state key]
  (let [frames-since-last-press
        (get-in state [:keyboard-state :frames-since-last-press])]
    (and (q/key-pressed?)
         (> frames-since-last-press
            (* @(settings/data :frame-rate) (/ key-delay-in-ms 1000)))
         (or (not (= (get-in state [:keyboard-state :prev-key]) key))
             (> frames-since-last-press 
                (* @(settings/data :frame-rate)
                   (/ double-tap-delay-in-ms 1000)))))))


(defn backspace-handler [state t key]
  (def the-key key)
  (if (and (= key \backspace)
           (> (count t) 0))
     (assoc state :repl-text (subs t 0 (- (count t) 1)))
     state))

(defn enter-handler [state t key]
  (if (and (or (= key \return)
               (= key \newline))
           (> (count t) 0))
    (assoc state
           :repl-output
           (try
             (str (binding [*ns* (find-ns 'daemon.face.core)]
                   (eval (read-string (str "(" (state :repl-text) ")")))))
             (catch Exception e
               (str e)
               (try
                 (str (binding [*ns* (find-ns 'daemon.face.core)]
                       (eval (read-string (str
                                           "(do (in-ns 'daemon-face.core) "
                                           (state :repl-text)
                                           ")")))))
                 (catch Exception e
                   "error"))))

           :repl-text
           "")

    state))

(defn keypress-handler [state]
  ;;extract goodies out of state
  (let [t (state :repl-text)
        key (q/raw-key)
        last-press-key [:keyboard-state :frames-since-last-press]]
   ;;debounce -should write this as a macro for an excersize
   (if (ready-to-accept-new-key? state key)
     
     ;;accept key
     (-> state
         ;;insert key if it is a standard char
         (#(if (not (or (q/key-coded? key) (or (= \return key) (= \newline key))))
             (assoc % :repl-text (str t key))
             %))

         (backspace-handler t key)
         (enter-handler     t key)

         ;;update state required for handling keys
         (assoc-in last-press-key 0)
         (assoc-in [:keyboard-state :prev-key] key))

     ;;no-keypress or decline
     (-> state
         (assoc-in last-press-key (+ 1 (get-in state last-press-key 0)))))))




















