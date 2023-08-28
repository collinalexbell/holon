
(in-package :holon)

(defclass goal ()
  ;; This is a pretty fleshed out goal class
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

(defun serialize-goal (goal)
  (list
   (slot-value goal 'name)
   (slot-value goal 'description)
   (slot-value goal 'why)
   (slot-value goal 'key-skills)))
