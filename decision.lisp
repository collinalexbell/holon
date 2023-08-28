(defpackage :h.decision (:use :cl))
(in-package :h.decision)

(defparameter global-decision-file-name "/Users/kuberlog/decisions")
(defparameter global-decisions (with-open-file (decision-file global-decision-file-name :direction :input)
                                (read decision-file)))

(defun save ()
  (with-open-file (decision-file global-decision-file-name :direction :output :if-exists :overwrite)
   (write global-decisions :stream decision-file)))

(defun make (description)
  (setf global-decisions (cons description global-decisions))
  (save))
