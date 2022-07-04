(defpackage :holon
  (:use :cl)
  (:export :holon :inferior-holons :link))

(in-package :holon)

(defclass holon ()
  ((name :initarg :name)
   (inferior-holons :initform '()
		    :initarg :inferior-holons
		    :accessor inferior-holons)
   (superior-holons :initform '()
                    :initarg :superior-holons
                    :accessor superior-holons)
   (parellel-holons :initform '()
                    :initarg :parellel-holons
                    :accessor parallel-holons)
   (state :initform 'intact)))

(defun holon ()
  (make-instance 'holon))

(defun cascade (holon fn)
  (funcall fn holon)
  (loop for holon in (slot-value holon 'inferior-holons)
	do (cascade holon fn)))

(defun shake (holon)
  (cascade holon #'renew))
(defgeneric renew (holon))
(defgeneric disolve (holon))


(defmethod link ((a holon) (b holon ))
  (loop for i in (list a b) do
       (let ((links (parallel-holons i)))
         (setf links (cons b links))))
  (let ((rv (holon)))
    (setf (inferior-holons rv) (list a b))
    rv))

(defmethod renew ((holon holon))
  (format t "An abstract holon is like a mathematical point.~%Therefore, there is nothing to it, so it can't be renewed"))

(defmethod disolve ((holon holon))
  (setf (slot-value holon 'state) 'disolved))
