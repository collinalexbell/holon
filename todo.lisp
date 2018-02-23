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
  (last-selected-time :accessor last-selected-time)))


(defun accumulate-work-time (the-todo)
  (let ((time-diff (- (get-universal-time) (last-selected-time the-todo))))
      (setf (todo-selected-duration the-todo)
         (+ (todo-selected-duration the-todo) time-diff))))
