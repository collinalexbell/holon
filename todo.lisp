(defclass todo ()
  ((description :accessor todo-description
		:initarg :description)
   (priority :accessor todo-priority
	     :initarg :priority
	     :initform 0)
   (groups :accessor todo-groups
	   :initarg :groups
	   :initform 0)
   (selected-duration :accessor todo-selected-duration
		      :initarg :selected-duration
		      :initform 0)
   (last-selected-time :accessor last-selected-time)
   (parent :accessor todo-parent
	   :initarg :parent
	   :initform nil)))

(defun new-todo (item priority todo-groups parent)
  (make-instance 'todo
		 :description item
		 :priority priority
		 :groups todo-groups
		 :parent (if (not (integerp parent))
			     (find-todo parent)
			     (nth parent
				  (filter-todos-by-group *todo-list*
							 *selected-group*)))))


(defun accumulate-work-time (the-todo)
  (let ((time-diff (- (get-universal-time) (last-selected-time the-todo))))
    (incf (todo-selected-duration the-todo) time-diff)
    (values (todo-selected-duration the-todo) time-diff)))

(define-test t-accumulate-work-time
  (let ((todo (make-instance 'todo)))
    (setf (last-selected-time todo) (get-universal-time))
    (setf (todo-selected-duration todo) 500)
    (sleep 1)
    (accumulate-work-time todo)
    (true (> (slot-value todo 'selected-duration) 500))
    (true (< (slot-value todo 'selected-duration) 504))))


(defun symbol-exists-p (sym)
  (fboundp sym))

(defun todo->a-symbol-name (description)
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
			(todo->a-symbol-name to-be-sym)
			(symbol-name to-be-sym))
		    (write-to-string to-be-sym)))
	      (progn
		(incf x)
		(concatenate 'string "_"
			     (if (not (integerp to-be-sym))
				 (if (listp to-be-sym)
				     (todo->a-symbol-name to-be-sym)
				     (symbol-name to-be-sym))
				 (write-to-string to-be-sym))))))
      description))))


(defun make-todo-action-hook-symbol (action description)
  (intern (concatenate 'string "HOOK-" (string action)
		       "-"
		       (todo->a-symbol-name description))))

(defun gen-hook (the-todo action)
  (let ((the-hook-sym
	 (make-todo-action-hook-symbol action 
				       (todo-description the-todo))))
    (when (symbol-exists-p the-hook-sym)
	(funcall (symbol-function the-hook-sym) the-todo))))

(defun add-todos (&optional (todos '()))
  ;;todos is a list of todos
  (loop for todo in todos
     do (add-todo todo)))

(defun say-selected-todo ()
  (let ((words (format nil "~a" (todo-description *selected-todo*))))
    (progn words nil)))
