(defun hook-complete-smile (the-todo)
  (format t "Please smile~%")
  (sleep 1)
  (loop for x from 0 to 3
        do (progn (format t "~a~%" x) (sleep 1) ))
  (format t "Snap!!!!!~%"))


