(ql:quickload :inferior-shell)
(ql:quickload :cl-store)
(load "timer.lisp")

(defpackage :todo
  (:use :timer :cl))


(in-package :todo)

(load "todo/globals.lisp")

(load "todo/todo.lisp")
;;class todo

;;;;TODO-LIST FNS;;;;;
(load "todo/todo-list.lisp")
;;complete-todo
;;sort-by-priority
;;add-templated-todos
;;add-todo
;;load-todos
;;save-todos
;;filter-todos-by-group
;;current-groups


;;;;PRINTING;;;;
(load "todo/printing.lisp")
;;print-todo-menu
;;print-current-groups
;;print-current-groups
;;print-todo-list
;;print-current-todo

(load "todo/api.lisp")

