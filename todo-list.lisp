(defun save-todos (&optional (file-name global-save-file))
  (cl-store:store todo-list file-name))

(defun load-todos (&optional (file-name global-save-file))
  (setf todo-list (cl-store:restore file-name)))

(defun add-todo (item &key (priority 0) (groups '()))
  (push 'all groups)
  (if (not (eq selected-group 'all))
      (progn
        (push selected-group groups)
        (loop for group in groups
              do (if (not (find group group-list))
                      (push group group-list)))))
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

(defun filter-todos-by-group (l g)
  (remove-if-not (lambda (t-d)
                   (find g (todo-groups t-d)))
                 l))

(defun current-groups () group-list)

(defun groups-in-todo-list ()
  (let ((current-groups '()))
    (loop for todo in todo-list
          do (loop for group in (todo-groups todo)
                   do (setf current-groups
                            (adjoin group current-groups))))
    current-groups))

(defun select-todo (item)
  (if (find item todo-list :test #'equal)
      (setf selected-todo item)
      (format t "Item does not exist in todo list")))


