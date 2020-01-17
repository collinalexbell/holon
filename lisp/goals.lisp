
(in-package :holon)

(defclass goal ()
    ((name :initarg :name)
     (description :initarg :description)
     (why-do-it :initarg :why)
     (tasks :initarg :tasks)))


(defun new-goal (name description why tasks)
  (make-instance 'goal
		 :name name
		 :description description
		 :why why
		 :tasks tasks))


(defmacro defgoal (name description why tasks)
  `(defparameter ,name
     (new-goal ',name
	       ',description
	       ',why
	       ',tasks)))
