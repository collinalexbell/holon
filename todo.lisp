;;;; Todo lists are the most important orginzational tool to get things done

(defparameter todo-list '())
(defparameter selected-todo nil)
(defparameter global-save-file "current.todo-list")

(defun save-todos (&optional (file-name global-save-file))
  (with-open-file (*standard-output* file-name :direction :output
                                               :if-does-not-exist :create
                                               :if-exists :supersede)
   (print todo-list)))

(defun load-todos (&optional (file-name global-save-file))
  (with-open-file (f file-name :direction :input)
    (setf todo-list (read f))))

(defun add-todo (item)
  (setf todo-list
        (cons item todo-list))
  (save-todos)
  (todos))


(defun complete-todo (item)
  (setf todo-list
   (delete item todo-list :test #'equal)))

(defun complete ()
  (complete-todo selected-todo)
  (setf selected-todo nil)
  (save-todos)
  (todos))


(defun select-todo (item)
  (if (find item todo-list :test #'equal)
      (setf selected-todo item)
      (format t "Item does not exist in todo list")))

(defun deselect ()
  (setf selected-todo nil)
  (todos))

(defun select (index)
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


(defun print-todo-menu ()
  (format t "~%-----<COMMANDS>-------~%~%")
  (format t "SELECT <#> | COMPLETE | DESELECT~%")
  (format t "~%-----</COMMANDS>------~%~%"))

(defun todos ()
  (print-current-todo)
  (print-todo-list)
  (print-todo-menu))

