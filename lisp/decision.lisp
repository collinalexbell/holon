(defpackage :h.decision (:use :cl))
(in-package :h.decision)

(defparameter global-decisions (with-open-file (decision-file "decisions" :direction :input)
                                (read decision-file)))

(defun save ()
  (write global-decisions :stream decision-file))

(defun make (description)
  (setf global-decisions (cons description global-decisions))
  (save))
