
(in-package :holon)

(defun familiar (name breed)
  `(familiar . (,name ,breed)))

(defun familiar-say-hello (familiar)
  (format nil "hello, I am ~s~%" (cadr familiar)))

(defun familiar-lets-go (familair)
  (format nil "~s, lets go" (cadr familair)))

(defun say (words)
  (inferior-shell:run (concatenate 'string "say " words)))
