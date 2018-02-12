;;;; Todo lists are the most important orginzational tool to get things done
(ql:quickload :inferior-shell)
(load "timer.lisp")

(defpackage :todo
  (:use :timer :cl))


(in-package :todo)

(defparameter todo-list '())
(defparameter selected-todo nil)
(defparameter global-save-file "current.todo-list")
(defparameter morning-template "todo/morning.todo-template")
(defparameter sleep-template "todo/sleep.todo-template")

(defun save-todos (&optional (file-name global-save-file))
  (with-open-file (*standard-output* file-name :direction :output
                                               :if-does-not-exist :create
                                               :if-exists :supersede)
   (print todo-list)))

(defun load-todos (&optional (file-name global-save-file))
  (with-open-file (f file-name :direction :input)
    (setf todo-list (read f))))

(defun add-todo (item priority)
        (push
         (cons (cons 'priority priority)
               (list item))
         todo-list)
  (setf todo-list (sort-by-priority todo-list))
  (save-todos)
  (todos))

(defun add-templated-todos (fname)
  (with-open-file (f fname :direction :input)
          (loop for todo in (read f)
                do (push `((priority . 9001) ,todo) todo-list)))
  (todos))

(defmacro get-priority (todo)
  `(cdr (assoc 'priority ,todo)))

(defun sort-by-priority (l)
  (sort l
        (lambda (a b) (> (get-priority a)
                         (get-priority b)))))


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
     (get-priority (nth index todo-list))
    priority))

(defun select-todo (item)
  (if (find item todo-list :test #'equal)
      (setf selected-todo item)
      (format t "Item does not exist in todo list")))

(defun deselect ()
  (setf selected-todo nil)
  (todos))

(defun select (&optional (index 0))
  (let ((todo (nth index todo-list)))
    (select-todo todo))
  (todos))

(defun print-current-todo ()
  (if selected-todo
      (format t "-----<Current TODO>---~%~a~%-----</Current TODO>--~%~%"
              selected-todo)))

(defun print-todo-list ()
  (if todo-list
      (progn
       (format t "-----<TODO List>------~%~%")
       (loop for todo in todo-list
             for i from 0 to (length todo-list)
             do (format t "~a) ~a~%~%" i todo))
       (format t "-----</TODO List>-----~%"))))

(defun remind (n sec min hour &optional (tomorrow nil))
  (let ((todo (nth n todo-list)))
   (labels ((play-sound ()
              (inferior-shell:run/nil '(afplay "/Users/taggart/Downloads/light.mp3")))
            (reminder ()
              (format t "~%YOU NEED TO ~a~%" todo)
              (sb-thread:make-thread #'play-sound)))
     (if tomorrow
         (schedule-tomorrow #'reminder sec min hour)
         (schedule-today #'reminder sec min hour)))))

(defun print-todo-menu ()
  (format t "~%-----<COMMANDS>-------~%~%")
  (format t "SELECT <#> | COMPLETE | DESELECT | REMIND <#> <SEC> <MIN> <HOUR>~%")
  (format t "~%-----</COMMANDS>------~%~%"))

(defun todos ()
  (print-current-todo)
  (print-todo-list)
  (print-todo-menu))

