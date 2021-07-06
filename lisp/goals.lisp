
(in-package :holon)

(defclass goal ()
    ((name :initarg :name)
     (description :initarg :description)
     (why-do-it :initarg :why)
     (key-skills :initarg :key-skills)
     (tasks :initarg :tasks)))


(defun new-goal (name description why key-skills)
  (make-instance 'goal
		 :name name
		 :description description
		 :why why
     :key-skills key-skills))


(defmacro defgoal (name description why key-skills)
  `(defparameter ,name
     (new-goal
      ',name
      ',description
      ',why
      ',key-skills)))
