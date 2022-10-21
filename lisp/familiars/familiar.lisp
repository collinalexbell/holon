
(in-package :holon)

(defun familiar (name breed)
  `(familiar . (,name ,breed)))

(defun familiar-say-hello (familiar)
  (format nil "hello, I am ~s~%" (cadr familiar)))

(defun familiar-lets-go (familair)
  (format nil "~s, lets go" (cadr familair)))

(defun familiar-sit (familiar)
`(,(cadr familiar) sit))

(defun familiar-come-here (familiar)
  `(,(cadr familiar) come here))


(defun say (words)
  (inferior-shell:run
   (concatenate 'string "say " (cond
                                 ((stringp words) words)
                                 ((listp words) (format nil "~{~a ~}" words))))))
