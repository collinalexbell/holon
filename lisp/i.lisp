(load "holon.lisp")
(load "human.lisp")
(in-package :holon)

(defun init-I ()
  (if (not (boundp 'I))
      (progn
        (defvar I (new-human 'Collin))
        (setf (slot-value I 'superior-holons)
              (concatenate 'list
                           '(USA NYC)
                           (slot-value I 'superior-holons)))
        (setf (slot-value I 'inferior-holons)
              (concatenate 'list
                           '(mind body)
                           (slot-value I 'inferior-holons))))))
(init-I)

(setf (inferior-holons I) (cons (familiar 'Zeus 'Poodle) (inferior-holons I)) )

(defun my-familiars ()
  (remove-if #'(lambda (holon) (not (and (listp holon) (eq 'familiar (car holon))))) (inferior-holons I)))
