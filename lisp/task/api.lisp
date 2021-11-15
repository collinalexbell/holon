(in-package :holon.task)

(defun complete ()
  (when (or (null (subtasks *selected-task*))
	    (yes-no "This task has subtasks.~%Do you wish to complete it?"))
    (let ((selected-task *selected-task*))
      (complete-task *selected-task*)
      (format t "You spent ~d seconds in total working on this task~%"
	      (task-selected-duration selected-task))))
  (redisplay)
  (backup *root-task*))

(defun delete-selected ()
  (delete-task *selected-task*)
  (format t "Is this an outdated task, if so remove it from task file too")
  (backup *root-task*))

(defun select-group (group)
  (cond
    ((integerp group) (setf *selected-group* (nth group (current-groups))))
    ((symbolp group) (if (find group (current-groups))
			 (setf *selected-group* group)
                         (error "That group doesn't exist")))
    (t (error "Group is not of type integer or symbol"))))

(defun deselect ()
  (unless (null *selected-task*)
    (multiple-value-bind (accumulated-time time-diff) (accumulate-work-time *selected-task*)
      (format t "You just spent ~d seconds on this incomplete task, for a total of ~d ~%" time-diff accumulated-time)
      (setf *selected-task* (.parent *selected-task*))
      time-diff)))

(defun select (&optional (index 0))
  (let ((task (nth index (filter-tasks-by-group (inferior-holons *selected-task*) *selected-group*))))
    (select-task task)
    (setf (last-selected-time task) (get-universal-time))
    (say-selected-task))
  (tasks))

(defun next ()
  (unless (null *selected-task*) (complete))
  (select))

(define-test test-select
  (let (((slot-value *selected-task* 'inferior-holons) '())
        (*selected-task* nil))
    (add-task '(test select))
    (select)
    (true (eq '(test select) (task-description *selected-task*)))
    (setf task::*selected-task* nil)
    (add-task '(test select 2))
    (select 1)
    (true (eq '(test select) (task-description *selected-task*)))))

(defun tasks ()
  (print-all-task-info))

(defun groups ()
  (print-current-groups))

