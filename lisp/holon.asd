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
               (:file "familiar")
               (:file "goals")
               (:file "restrictions")
               (:file "task/init")
               (:file "human")
               (:file "commitment/commitment")
               (:file "familiars/familiar")
               (:file "i")
               (:file "youtube")
               (:file "mastery")
               (:file "pomodoro")
               (:file "daemon/daemons")
               (:file "behavioural-exceptions")))

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

