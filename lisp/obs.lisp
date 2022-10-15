(defun rename (video name)
  ;; to be implemented, placeholder list rv
  `(,video ,name))

(defun ask-for-name () (format t "what should the name be ~%"))

(defun record ()
  (let ((video (obs)))
    (rename video (ask-for-name))))

(defun obs ()
  ;; to be implemented
  ;; do something to start obs
  nil)
