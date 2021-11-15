(in-package :holon)

(defun init-I ()
  (defvar I (new-human 'Collin))
  (setf (slot-value I 'superior-holons)
        (concatenate 'list
                     '(USA Tennessee)
                     (slot-value I 'superior-holons)))
  (setf (slot-value I 'inferior-holons)
        (concatenate 'list
                     '(mind body)
                     (slot-value I 'inferior-holons))))
(init-I)
