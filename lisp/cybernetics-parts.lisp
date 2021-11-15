(defpackage :holon.cybernetics.parts (:use :cl))
(in-package :holon.cybernetics.parts)

(defmacro def-parts-category (name parts)
  `(defparameter ,name ,parts))

(defvar def-parts-category-usage
  '(def-parts-category spirit '(rpi rpi)))

(defmacro def-parts-categories (&rest parts)
  `(progn
     ,@(loop for part in parts collect `(def-parts-category ,(car part) (quote ,(cadr part))))))

(defvar def-parts-categories-usage
  '(def-parts-categories (spirit (rpi arduino rpi)) (body (motor motor))))



