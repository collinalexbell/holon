
(in-package :holon)

(defun familiar (name breed)
  `(familiar . (,name ,breed)))

(defun familiar-say-hello (familiar)
  (format t "hello, I am ~s~%" familiar))
