
(in-package :holon)

(defun familiar (name breed)
  `(familiar . (,name ,breed)))

(defun familiar-say-hello (familiar)
  (format t "hello, I am ~s~%" familiar))

(defun familiar-lets-go (familair)
  (format t "~s, lets go" familair))

(defun say (words)
  (inferior-shell:run (concatenate 'string "say " words)))
