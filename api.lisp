(defun complete ()
  (format t "You spent ~d seconds in total working on this todo~%"
          (todo-selected-duration *selected-todo*))
  (complete-todo *selected-todo*)
  (save-and-redisplay))

(defun delete-selected ()
  (delete-todo *selected-todo*))

(defun select-group (group)
  (cond
    ((integerp group) (setf *selected-group* (nth group (current-groups))))
    ((symbolp group) (if (find group (current-groups)) (setf *selected-group* group)
                         (error "That group doesn't exist")))
    (t (error "Group is not of type integer or symbol"))))

(define-test select-group-test
  (define-test select-group-by-integer-test
    (let ((*selected-group* nil))
      (select-group (- (length *group-list*) 3))
      (true (eq *selected-group* 'all))))
  (define-test select-group-symbol-test
    (let ((*selected-group* nil))
      (select-group 'all)
      (true (eq *selected-group* 'all))))
  (define-test select-group-error-test
    (fail (select-group "winning"))))

(defun deselect ()
  (multiple-value-bind (accumulated-time time-diff) (accumulate-work-time *selected-todo*)
    (format t "You just spent ~d seconds on this incomplete todo, for a total of ~d ~%" time-diff accumulated-time)
    (setf *selected-todo* nil)
    time-diff))

(defun select (&optional (index 0))
  (let ((todo (nth index (filter-todos-by-group *todo-list* *selected-group*))))
    (select-todo todo)
    (setf (last-selected-time todo) (get-universal-time))
    (say-selected-todo))
  (todos))

(defun todos ()
  (print-current-todo)
  (print-todo-list)
  (print-todo-menu))

(defun groups ()
  (print-current-groups))


(defun add-group (group)
  (if (not (find group *group-list*))
      (progn (push group *group-list*)
             (save-groups))))


(defun delete-group (group)
  (if (find group (groups-in-todo-list))
      (error "This group cannot be deleted because a live todo is in it"))
  (setf *group-list* (delete group *group-list*))
  (save-groups))
