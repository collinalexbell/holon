(in-package :holon)

(defun init-I ()
 (defvar I (new-holon 'I))
  (setf (slot-value I 'superior-holons)
	(concatenate 'list
		     '(USA Tennessee Kroger)
		     (slot-value I 'superior-holons))))
