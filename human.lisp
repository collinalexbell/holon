(in-package :holon)

(defclass human (holon)
  ())

(defmethod renew ((person human))
  (format t "Have a good rest human."))

(defun new-human (name)
  (make-instance 'human :name name))
