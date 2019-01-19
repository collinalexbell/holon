(in-package :holon)


(defun get-leverage (change-to-be-made)
  (change-pleasure-link change-to-be-made)
  (change-pain-link change-to-be-made))

(defun change-pain-link (change-to-be-made)
  (format t "Think of the worst thing that could result from not ~a" change-to-be-made)
  (read-line)
  (format t "Feel what it would be like to experience the worst thing")
  (read-line))

(defun change-pleasure-link (change-to-be-made)
  (format t "Think of the best thing that could result from ~a" change-to-be-made)
  (read-line)
  (format t "Feel what it would be like to obtain that best thing")
  (read-line))

(defun apply-leverage (change-to-be-made)
  (format t "Now do one action that commits me to ~a" change-to-be-made))

(defun change (change-to-be-made)
  (get-leverage change-to-be-made)
  (apply-leverage change-to-be-made))
