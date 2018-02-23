(ql:quickload :inferior-shell)
(ql:quickload :cl-store)
(load "timer.lisp")

(defpackage :todo
  (:use :timer :cl))

(in-package :todo)

(load "todo/globals.lisp")
(load "todo/todo.lisp")
(load "todo/todo-list.lisp")
(load "todo/printing.lisp")
(load "todo/api.lisp")

