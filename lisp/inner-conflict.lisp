(defpackage :holon.guru (:use :cl))
(in-package :holon.guru)

;; again, this was stolen directly from Tony Robbins


(defun identify-inner-conflict-about (x)
  (format t "Think about what is holding me back in ~a. Write that thing down." x)
  (let (( the-thing (read-line)))
   (format t "Think about what I value that causes me to want ~a.~% Input it as a list now >> " the-thing)
   (read-line)))

(defun re-align-conflicting-values (conflicting-values)
  (format t "Think about which values are most important in:~%~a~%"
	  conflicting-values)
  (read-line)
  (format t "Think about how to balance these values and write the new plan~%")
  (read-line))

(defun become-congruent-about (x)
  (re-align-conflicting-values
   (concatenate 'list `(,(identify-inner-conflict-about x)) `(,x))))

