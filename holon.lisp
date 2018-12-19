
(defpackage :holon
  (:use :cl))

(in-package :holon)


(defclass holon ()
  ((name :initarg :name)
   (inferior-holons :initform '())
   (superior-holons :initform '())))

(defun new-holon (name)
  (make-instance 'holon :name name))

(load "task/init.lisp")
