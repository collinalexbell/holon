(in-package :holon.daemons)

(defun hyper-driver (&rest args)
  (if (= (length args) 0)
      (format t "usage: wear hyper-driver for warmth and input")))
