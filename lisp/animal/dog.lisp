(defpackage :dog
  (:use :cl))

(in-package :dog)

(defun look-at (thing)
  (let ((subject thing))
    (think-about subject)))

(defun think-about (subject))
(defun intend (to))
