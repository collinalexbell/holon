(defpackage :holon.treelon (:use :cl))
(in-package :holon.treelon)

(defun select-substance (x y) (progn (+ x y) #\-))

(defun treelon ()
  ;; a simulation world for all holons, but especially kuberlog
  ;; think of it a bit like an RPG game

  (let ((map (loop for y from 0 to 100
               collect
               (loop for x from 0 to 100
                     collect `(,(select-substance x y) ((x . ,x) (y . ,y)))))))
    (loop for y in map do (progn (loop for x in y do (princ (car x))) (format t "~%")))))
