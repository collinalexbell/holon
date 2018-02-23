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

