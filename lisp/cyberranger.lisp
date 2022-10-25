(load "holon.lisp")
(load "profession.lisp")
(defpackage :holon.cyber-ranger (:use :cl :holon :profession))

(in-package :holon.cyber-ranger)

(defclass cyber-ranger (holon) ((profession :initarg :profession)))

(defun new-cyber-ranger (rangers-name)
  (make-instance 'cyber-ranger
                 :profession (profession:new-profession "cyber-ranger")
                 :name rangers-name))


;; different than the I in the holon package
(defvar I (new-cyber-ranger "kuberlog"))
