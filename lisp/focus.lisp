
(in-package :holon)


;; look how small this function is
;; no wonder I cant get anything done
(defun focus (&key ((:on thing-to-focus-on)))
  (format t "Stand/sit up tall")
  (read-line)
  (format t "Breath deeply with energy")
  (read-line)
  (format t "Think, I will focus on ~a" thing-to-focus-on))
