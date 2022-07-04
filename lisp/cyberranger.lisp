(load "holon.lisp")
(load "profession.lisp")
(defpackage :cyber-ranger (:use :cl :holon :profession))

(in-package :cyber-ranger)

(defclass cyber-ranger (holon) ((profession :initarg :profession)))

(defun new-cyber-ranger (rangers-name)
  (make-instance 'cyber-ranger
                 :profession (profession:new-profession "cyber-ranger")
                 :name rangers-name))


(defvar I ())
