(in-package :holon)

(defclass human (holon)
  (tasks))

(defmacro with-human (the-human body))

(defmethod renew ((person human))
  (format t "Have a good rest human."))

(defun new-human (name)
  (make-instance 'human :name name))
