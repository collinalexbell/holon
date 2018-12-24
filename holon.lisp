(defpackage :holon
  (:use :cl))

(in-package :holon)


(defclass holon ()
  ((name :initarg :name)
   (inferior-holons :initform '())
   (superior-holons :initform '())))

(defun new-holon (name)
  (make-instance 'holon :name name))

(defun cascade (holon fn)
  (funcall fn holon)
  (loop for holon in (slot-value holon 'inferior-holons)
	do (cascade holon fn)))

(load "love.lisp")
(load "focus.lisp")
(load "plans.lisp")
(load "restrictions.lisp")
(load "task/init.lisp")
(load "i.lisp")

