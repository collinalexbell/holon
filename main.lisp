(ql:quickload :inferior-shell)
(ql:quickload :cl-store)
(load "timer.lisp")

(defpackage :todo
  (:use :timer :cl))

(load "todo/globals.lisp")

(in-package :todo)

(defclass todo ()
  ((description :accessor todo-description
                :initarg :description)
   (priority :accessor todo-priority
             :initarg :priority
             :initform 0)
   (groups :accessor todo-groups
           :initarg :groups
           :initform 0)))

;;;;TODO-LIST FNS;;;;;
(load "todo/todo-list.lisp")
;;complete-todo
;;sort-by-priority
;;add-templated-todos
;;add-todo
;;load-todos
;;save-todos

(defun complete ()
  (complete-todo selected-todo)
  (setf selected-todo nil)
  (save-todos)
  (todos))

(defun current-groups ()
  (let ((current-groups '()))
    (loop for todo in todo-list
          do (loop for group in (todo-groups todo)
                   do (setf current-groups
                            (adjoin group current-groups))))
    current-groups))

(defun select-group (index)
  (setf selected-group (nth index (current-groups)))
  (todos))

(defun filter-todos-by-group (l g)
  (remove-if-not (lambda (t-d)
                   (find g (todo-groups t-d)))
                 l))

(defun select-todo (item)
  (if (find item todo-list :test #'equal)
      (setf selected-todo item)
      (format t "Item does not exist in todo list")))

(defun deselect ()
  (setf selected-todo nil)
  (todos))

(defun select (&optional (index 0))
  (let ((todo (nth index (filter-todos-by-group todo-list selected-group))))
    (select-todo todo))
  (todos))

(defun remind (n sec min hour &optional (tomorrow nil))
  (let ((todo (nth n (filter-todos-by-group todo-list selected-group))))
   (labels ((play-sound ()
              (inferior-shell:run/nil '(afplay "/Users/taggart/Downloads/light.mp3")))
            (reminder ()
              (format t "~%YOU NEED TO ~a~%" todo)
              (sb-thread:make-thread #'play-sound)))
     (if tomorrow
         (schedule-tomorrow #'reminder sec min hour)
         (schedule-today #'reminder sec min hour)))))

;;;;PRINTING;;;;
(load "todo/printing.lisp")
;;print-todo-menu
;;print-current-groups
;;print-current-groups
;;print-todo-list
;;print-current-todo

(defun todos ()
  (print-current-todo)
  (print-todo-list)
  (print-todo-menu))

(defun groups ()
  (print-current-groups))
