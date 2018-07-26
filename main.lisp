(ql:quickload :inferior-shell)
(ql:quickload :cl-store)
(ql:quickload :parachute)
(ql:quickload :postmodern)

(defpackage :todo
  (:use :cl :parachute :postmodern)
  (:export :select :complete :deselect :add-todo))

(in-package :todo)

(defun run-all-package-tests ()
  (test 'select-group-test)
  (test 'add-todo-test)
  (test 'find-todo-test))

(defun init ()
  (load "todo/globals.lisp")
  (load "todo/todo.lisp")
  (load "todo/todo-list.lisp")
  (load "todo/printing.lisp")
  (load "todo/api.lisp")
  (load "todo/storage.lisp")
  (load "todo/hooks.lisp"))

(init)
