(defun remove-nth (n list)
  (declare
   (type (integer 0) n)
   (type list list))
  (if (or (zerop n) (null list))
      (cdr list)
      (cons (car list) (remove-nth (1- n) (cdr list)))))

(defun save-groups (&optional (file-name *global-group-file*))
  (cl-store:store *group-list* file-name))

(defun load-groups (&optional (file-name *global-group-file*))
  (setf *group-list* (cl-store:restore file-name)))

(defun save-todos (&optional (file-name *global-save-file*))
  (cl-store:store *todo-list* file-name))

(defun save-and-redisplay ()
  (save-todos)
  (todos))

(defun delete-todos (&rest indicies)
  (loop for i in indicies do (setf *todo-list* (remove-nth i *todo-list*))))

(defun load-todos (&optional (file-name *global-save-file*))
  (setf *todo-list* (cl-store:restore file-name)))

(defun add-new-groups-to-group-list (groups)
  (loop for group in groups
        do (if (not (find group *group-list*))
               (add-group group))))

(defun push-todo-and-re-sort (todo-instance)
  (push todo-instance *todo-list*)
  (setf *todo-list* (sort-by-priority *todo-list*)))

(defun add-todo (item &key (priority 0) (todo-groups '()))
  (push 'all todo-groups)
  (if (not (eq *selected-group* 'all)) (push *selected-group* todo-groups))
  (add-new-groups-to-group-list todo-groups)
  (push-todo-and-re-sort
   (make-instance 'todo :description item :priority priority :groups todo-groups))
  (save-and-redisplay))

(define-test add-todo-test
  (let ((*todo-list* '())
        (*group-list* '()))
    (add-todo '(all i do is test) :todo-groups '(test))
    (true (find 'test *group-list*))
    (true (= 1 (length *todo-list*)))))

(defun add-templated-todos (fname)
  (with-open-file (f fname :direction :input)
    (loop for todo in (read f)
          do (add-todo todo :priority 9001 :todo-groups '(templated))))
  (todos))

(defun sort-by-priority (l)
  (sort l
        (lambda (a b) (> (todo-priority a)
                         (todo-priority b)))))

(defun complete-todo (item)
  (accumulate-work-time *selected-todo*)
  (save-completed-todo *selected-todo*)
  (setf *selected-todo* nil)
  (setf *todo-list*
        (delete item *todo-list* :test #'equal)))

(defun delete-todo (item)
  (setf *selected-todo* nil)
  (setf *todo-list*
        (delete item *todo-list* :test #'equal)))

(defun filter-todos-by-group (l g)
  (remove-if-not (lambda (t-d)
                   (find g (todo-groups t-d)))
                 l))

(defun current-groups () *group-list*)

(defun groups-in-todo-list ()
  (let ((current-groups '()))
    (loop for todo in *todo-list*
          do (loop for group in (todo-groups todo)
                   do (setf current-groups
                            (adjoin group current-groups))))
    current-groups))

(defun select-todo (item)
  (if (find item *todo-list* :test #'equal)
      (setf *selected-todo* item)
      (format t "Item does not exist in todo list")))


