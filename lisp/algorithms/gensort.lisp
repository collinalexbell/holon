
(defun gensort (args)
  (let (
               (n 0)
               (r 10000))
           (if (>= (length args) 1)
               (setf n (nth 0 args))
               (return-from main nil))
           (if (>= (length args) 2)
               (setf r (nth 1 args)))
           (loop for i from 0 to n collect
             (let ((sign (if (eq (random 2) 1) -1 1)))
               (* (random r) sign)))))


