(ql:quickload :inferior-shell)
(ql:quickload :cl-store)
(ql:quickload :parachute)
(ql:quickload :postmodern)

(defpackage :todo
  (:use :cl :parachute :postmodern)
  (:export :select :complete :deselect :add-todo))

(in-package :todo)

(defun run-all-package-tests ()
  (dolist (test-name
	   '(t-delete-todo t-select-todo t-find-todo
	     t-complete-todo))
    (test test-name)))

(defun init ()
  (load "globals.lisp")
  (load "todo.lisp")
  (load "storage.lisp")
  (load "todo-list.lisp")
  (load "printing.lisp")
  (load "api.lisp")
  (load "hooks.lisp"))

(init)
(run-all-package-tests)

;; a way to integrate todo with the rest of alexandria is to provide a macro with-todos that dynamically lets *todo-list* to the todo 
