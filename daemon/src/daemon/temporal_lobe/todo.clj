(ns daemon.temporal-lobe.todo
  (:require
   [daemon.settings :as settings]
   [daemon.voice.core :as voice]))


(defn load-todo-file
  "Attempts to find the todo file. If it can not, then it will say so."
  []
  (try
    settings/todo-file
    (catch Exception e (voice/speak "I can not find your todo list."))))
















