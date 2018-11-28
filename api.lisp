(in-package :todo)

(defun complete ()
  (let ((selected-todo *selected-todo*))
    (complete-todo *selected-todo*)
    (format t "You spent ~d seconds in total working on this todo~%"
            (todo-selected-duration selected-todo)))
  (save-and-redisplay))

(defun delete-selected ()
  (delete-todo *selected-todo*))

(defun select-group (group)
  (cond
    ((integerp group) (setf *selected-group* (nth group (current-groups))))
    ((symbolp group) (if (find group (current-groups))
			 (setf *selected-group* group)
                         (error "That group doesn't exist")))
    (t (error "Group is not of type integer or symbol"))))

(defun deselect ()
  (unless (null *selected-todo*)
    (multiple-value-bind (accumulated-time time-diff) (accumulate-work-time *selected-todo*)
      (format t "You just spent ~d seconds on this incomplete todo, for a total of ~d ~%" time-diff accumulated-time)
      (setf *selected-todo* nil)
      time-diff)))

(defun select (&optional (index 0))
  (deselect)
  (let ((todo (nth index (filter-todos-by-group *todo-list* *selected-group*))))
    (select-todo todo)
    (setf (last-selected-time todo) (get-universal-time))
    (say-selected-todo))
  (todos))

(defun next ()
  (unless (null *selected-todo*) (complete))
  (select))

(define-test test-select
  (let ((*todo-list* '())
        (*selected-todo* nil))
    (add-todo '(test select))
    (select)
    (true (eq '(test select) (todo-description *selected-todo*)))
    (setf todo::*selected-todo* nil)
    (add-todo '(test select 2))
    (select 1)
    (true (eq '(test select) (todo-description *selected-todo*)))))

(defun todos ()
  (print-all-todo-info))

(defun groups ()
  (print-current-groups))

