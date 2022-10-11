(in-package :holon)
(defclass human (holon)
  (tasks
   (profession
    :initform '()
    :initarg profesion
    :accessor profession)))

(defmacro with-human (the-human body))

(defmethod renew ((person human))
  (format t "Have a good rest human."))

(defun new-human (name)
  (make-instance 'human :name name))
