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
               (:file "inner-conflict")))

;; (ql:quickload :holon) to install dependencies


;; how to load holon after booting
; kuberlog
; <password>
; startx
; cmd+d
; emacs
; <enter>
; c-x c-f /home/kuberlog/code/holon/lisp/holon.asd
; slime
; (asdf:load-system :holon)
; 5 (on error)

