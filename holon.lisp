(defpackage :holon
  (:use :cl))

(in-package :holon)


(defclass holon ()
  ((name :initarg :name)
   (inferior-holons :initform '())
   (superior-holons :initform '())))

(defvar god (new-holon "god" '()))

(define-condition only-one-god (error) ())

(defun new-holon (name inferior-holons)
  (if (or (not (listp inferior-holons)) (null inferior-holons))
      (error 'only-one-god)
      (make-instance 'holon :name name)))

(defun cascade (holon fn)
  (funcall fn holon)
  (loop for holon in (slot-value holon 'inferior-holons)
	do (cascade holon fn)))

(defun shake (holon)
  (cascade holon #'renew))

(defgeneric renew (holon))

(defmethod renew ((holon holon))
  (format t "An abstract holon is like a mathematical point.~%Therefore, there is nothing to it, so it can't be renewed"))


