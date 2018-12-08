(in-package :todo)

(defun add-cleaning-todos ()
  (let ((cleaning-todos '((make bed)
			  (pick up desk)
			  (pick up floor))))
    (loop for todo in cleaning-todos
	  do (add-todo todo))
    (todos)))
