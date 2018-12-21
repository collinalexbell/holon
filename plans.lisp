
(in-package :holon)

(defclass plan ()
    ((name :initarg :name)
     (description :initarg :description)
     (why-do-it :initarg :why)
     (tasks :initarg :tasks)))


(defun new-plan (name description why tasks)
  (make-instance 'plan
		 :name name
		 :description description
		 :why why
		 :tasks tasks))
