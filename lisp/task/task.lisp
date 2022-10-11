(in-package :holon.task)
(defclass task (holon)
  ((description :accessor task-description
		:initarg :description)
   (priority :accessor task-priority
	     :initarg :priority
	     :initform 0)
   (groups :accessor task-groups
	   :initarg :groups
	   :initform 0)
   (selected-duration :accessor task-selected-duration
		      :initarg :selected-duration
		      :initform 0)
   (last-selected-time :accessor last-selected-time)
   (parent :accessor .parent
	   :initarg :parent
	   :initform nil)))

(defun new-task (item priority task-groups parent)
  (make-instance 'task
		 :description item
		 :priority priority
		 :groups task-groups
		 :parent parent))

(defun subtasks (task)
  (inferior-holons task))

(defun accumulate-work-time (the-task)
  (let ((time-diff (- (get-universal-time) (last-selected-time the-task))))
    (incf (task-selected-duration the-task) time-diff)
    (values (task-selected-duration the-task) time-diff)))

(parachute:define-test t-accumulate-work-time
  (let ((task (make-instance 'task)))
    (setf (last-selected-time task) (get-universal-time))
    (setf (task-selected-duration task) 500)
    (sleep 1)
    (accumulate-work-time task)
    (true (> (slot-value task 'selected-duration) 500))
    (true (< (slot-value task 'selected-duration) 504))))


(defun symbol-exists-p (sym)
  (fboundp sym))

(defun task->a-symbol-name (description)
  (reduce
   #'(lambda (str1 str2)
       (concatenate 'string str1 str2))
   (let ((x 0))
     (mapcar
      #'(lambda (to-be-sym)
	  (if (zerop x) 
	      (progn
		(incf x)
		(if (not (integerp to-be-sym))
		    (if (listp to-be-sym)
			(task->a-symbol-name to-be-sym)
			(symbol-name to-be-sym))
		    (write-to-string to-be-sym)))
	      (progn
		(incf x)
		(concatenate 'string "_"
			     (if (not (integerp to-be-sym))
				 (if (listp to-be-sym)
				     (task->a-symbol-name to-be-sym)
				     (symbol-name to-be-sym))
				 (write-to-string to-be-sym))))))
      description))))


(defun make-task-action-hook-symbol (action description)
  (intern (concatenate 'string "HOOK-" (string action)
		       "-"
		       (task->a-symbol-name description))))

(defun gen-hook (the-task action)
  (let ((the-hook-sym
	 (make-task-action-hook-symbol action
				       (task-description the-task))))
    (when (symbol-exists-p the-hook-sym)
	(funcall (symbol-function the-hook-sym) the-task))))

(defun say-selected-task ()
  (let ((words (format nil "~a" (task-description *selected-task*))))
    (progn words nil)))
