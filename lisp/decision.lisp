(defpackage :h.decision (:use :cl))
(in-package :h.decision)

(defvar global-decisions '())

(defun make (description)
  (setf global-decisions (cons description global-decisions)))
