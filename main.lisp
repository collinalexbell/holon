(ql:quickload :inferior-shell)
(ql:quickload :cl-store)
(ql:quickload :parachute)

(load "timer.lisp")

(defpackage :todo
  (:use :timer :cl :parachute :core))

(in-package :todo)

(load "todo/globals.lisp")
(load "todo/todo.lisp")
(load "todo/todo-list.lisp")
(load "todo/printing.lisp")
(load "todo/api.lisp")


(defun run-all-package-tests ()
  (test 'select-group-test)
  (test 'add-todo-test))
