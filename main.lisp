(ql:quickload :inferior-shell)
(ql:quickload :cl-store)
(ql:quickload :parachute)
(ql:quickload :postmodern)

(defpackage :todo
  (:use :cl :parachute :postmodern)
  (:export :select :complete :deselect))

(in-package :todo)

(load "alexander.todo/globals.lisp")
(load "alexander.todo/todo.lisp")
(load "alexander.todo/todo-list.lisp")
(load "alexander.todo/printing.lisp")
(load "alexander.todo/api.lisp")


(defun run-all-package-tests ()
  (test 'select-group-test)
  (test 'add-todo-test))
