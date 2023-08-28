(defpackage :profession (:use :cl :holon) (:export :new-profession))
(in-package :profession)

(defclass profession (holon) ())

(defun new-profession (name) (make-instance 'profession :name name))
