(defpackage :holon
  (:use :cl))

(in-package :holon)

(defclass holon ()
  ((name :initarg :name)
   (inferior-holons :initform '() :initarg :inferior-holons)
   (superior-holons :initform '() :initarg :superior-holons)
   (state :initform 'intact)))

;;;A god holon allows a holarchy to be formed with 1 root node
(defvar god (new-holon "god"))

(defun new-holon (name &optional
			 (inferior-holons '())
			 (superior-holons '()))
  (push superior-holons god)
  (make-instance 'holon :name name
			:inferior-holons inferior-holons
			:superior-holons superior-holons))

(defun cascade (holon fn)
  (funcall fn holon)
  (loop for holon in (slot-value holon 'inferior-holons)
	do (cascade holon fn)))

(defun shake (holon)
  (cascade holon #'renew))

(defgeneric renew (holon))
(defgeneric disolve (holon))

(defmethod renew ((holon holon))
  (format t "An abstract holon is like a mathematical point.~%Therefore, there is nothing to it, so it can't be renewed"))

(defmethod disolve ((holon holon))
  (dolist (inferior-holon (slot-value holon 'inferior-holons))
    (disolve inferior-holon))
  (setf (slot-value holon 'state) 'disolved))


