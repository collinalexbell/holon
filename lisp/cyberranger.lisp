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

(defparameter *cpm* 1)

(defun views-per-day-to-hit-target (&optional
                     ;;the number of dollars to achieve
                     (target 6000)

                     ;; duration-days is the number of days to achiev it
                     (duration-days 30))

  (let ((total-views (* target 1000 *cpm*)))
    `(views per day ,(/ total-views duration-days) for ,target dollars in ,duration-days days)))
