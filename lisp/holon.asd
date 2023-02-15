(require 'asdf)
(defsystem "holon"
  :description "a conceptual context"
  :version "1.1"
  :author "kuberlog <collinalexbelL@gmail.com>"
  :license "tree"
  :depends-on ("parachute"
               "postmodern"
               "cl-store"
               "inferior-shell")
  :components ((:file "holon")
               (:file "love")
               (:file "focus")
               (:file "goals")
               (:file "restrictions")
               (:file "task/init")
               (:file "human")
               (:file "commitment/commitment")
               (:file "familiars/familiar")
               (:file "position")
               (:file "i")
               (:file "corporation")
               (:file "youtube")
               (:file "mastery")
               (:file "pomodoro")
               (:file "daemon/Daemon")
               (:file "daemon/daemons")
               (:file "behavioural-exceptions")
               (:file "inner-conflict")
               (:file "vision/vision")
               (:file "change/change")))

; emacs
; slime into project dir
; (load "init.lisp")

