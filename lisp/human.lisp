(in-package :holon)
(defclass human (holon)
  (tasks
   (profession
    :initform '()
    :initarg profesion
    :accessor profession)
   (positions
    :initform '()
    :initarg positions
    :accessor positions)))

(defmacro with-human (the-human body))

(defmethod renew ((person human))
  (format t "Have a good rest human."))

(defun new-human (name)
  (make-instance 'human :name name))

(defun moved (human position)
  (setf (positions human) (add-position (positions human) position)))

(defun save (human file)
  (cl-store:store human file))

(defun restore (file)
  (cl-store:restore file))
