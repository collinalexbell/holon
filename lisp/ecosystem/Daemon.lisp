(defpackage :holon.Daemon (:use :cl))
(in-package :holon.Daemon)

(defclass Daemon () (
                     (name :initarg :name :accessor name)
                     (description :initarg :description)
                     (approx-marginal-cost :initarg :approx-marginal-cost :initform nil)))


(defun print-daemon (daemon)
  (let ((marginal-cost (slot-value daemon 'approx-marginal-cost)))

    (format nil (concatenate 'string
                             "name: ~a~%description: ~a~%"
                             (if (not (null marginal-cost)) "approx-marginal-cost: ~a~%" "")
                             "~%")

            (slot-value daemon 'name)
            (slot-value daemon 'description)
            (if (not (null marginal-cost))
                marginal-cost
                ""))))

(defun serialize (daemon)
  `(,(slot-value daemon 'name) .
    ((:description . ,(slot-value daemon 'description))
     (:approx-marginal-cost . ,(slot-value daemon 'approx-marginal-cost)))))


