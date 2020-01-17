
(in-package :holon)

(defun focus (&key ((:on thing-to-focus-on)))
  (format t "Stand/sit up tall")
  (read-line)
  (format t "Breath deeply with energy")
  (read-line)
  (format t "Think, I will focus on ~a" thing-to-focus-on))
