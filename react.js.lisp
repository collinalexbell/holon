(defpackage :holon.react (:use :cl))

(in-package :holon.react)

(defun tag (name)
  (let ((*print-case* :downcase))
    (format t "<~s></~s>" name name)))

(defun component (name &optional children)
    (let ((*print-case* :capitalize))
      (if (null children)
          (format nil "<~s/>" name)
          (concatenate 'string
            (format nil "<~s>" name )
            (apply #'concatenate 'string (loop for child in children collect (princ-to-string child)))
            (format nil "</~s>" name )))))
