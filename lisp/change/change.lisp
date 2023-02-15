(in-package :holon)


;; this idea was stolen from Tony Robbins
;; and encoded into lisp
;; cc* Tony

(defun wait-for-user () (read-line))

(defun get-leverage (change-to-be-made)
  (change-pleasure-link change-to-be-made)
  (change-pain-link change-to-be-made))

(defun change-pain-link (change-to-be-made)
  (format t "Think of the worst thing that could result from not ~a" change-to-be-made)
  (wait-for-user)
  (format t "Feel what it would be like to experience the worst thing")
  (wait-for-user))

(defun change-pleasure-link (change-to-be-made)
  (format t "Think of the best thing that could result from ~a" change-to-be-made)
  (wait-for-user)
  (format t "Feel what it would be like to obtain that best thing")
  (wait-for-user))

(defun apply-leverage (change-to-be-made)
  (format t "Now do one action that commits me to ~a" change-to-be-made))

(defun change (change-to-be-made)
  (get-leverage change-to-be-made)
  (apply-leverage change-to-be-made))


; *cc -> creative commons
