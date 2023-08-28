(defpackage :restriction
  (:use :cl))

(defparameter current '())

(defclass restriction ()
  (description
   reminder-date
   reminder-fn))

(defun new-restriction (description)
  (let ((rv (make-instance 'restriction)))
    (setf (slot-value rv 'description) description)
    rv))

(defun add-restriction (description)
  (push (new-restriction description) current))
