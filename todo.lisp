;;;; Todo lists are the most important orginzational tool to get things done
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

(defun save-todos (&optional (file-name global-save-file))
  (cl-store:store todo-list file-name))

(defun load-todos (&optional (file-name global-save-file))
  (setf todo-list (cl-store:restore file-name)))

(defun add-todo (item &key (priority 0) (groups '()))
  (push 'all groups)
  (push
   (make-instance 'todo :description item :priority priority :groups groups)
   todo-list)
  (setf todo-list (sort-by-priority todo-list))
  (save-todos)
  (todos))

(defun add-templated-todos (fname)
  (with-open-file (f fname :direction :input)
          (loop for todo in (read f)
                do (add-todo todo :priority 9001)))
  (todos))

(defun sort-by-priority (l)
  (sort l
        (lambda (a b) (> (todo-priority a)
                         (todo-priority b)))))


(defun complete-todo (item)
  (setf todo-list
   (delete item todo-list :test #'equal)))

(defun complete ()
  (complete-todo selected-todo)
  (setf selected-todo nil)
  (save-todos)
  (todos))

(defun adjust-priority (index priority)
   (setf
    (get-priority (nth index (filter-todos-by-group todo-list selected-group)))
     priority)
  (setf todo-list (sort-by-priority todo-list)))


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
