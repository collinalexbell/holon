(in-package :holon.daemons)

(defun steel-raven (&rest args)
  (if (= (length args) 0)
      (format t "usage: train steel-raven to hack")))
