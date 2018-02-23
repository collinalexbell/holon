(defun complete ()
  (complete-todo selected-todo)
  (setf selected-todo nil)
  (save-todos)
  (todos))

(defun select-group (index)
  (setf selected-group (nth index (current-groups)))
  (todos))

(defun deselect ()
  (setf selected-todo nil)
  (todos))

(defun select (&optional (index 0))
  (let ((todo (nth index (filter-todos-by-group todo-list selected-group))))
    (select-todo todo))
  (todos))

(defun todos ()
  (print-current-todo)
  (print-todo-list)
  (print-todo-menu))

(defun groups ()
  (print-current-groups))

(defun remind (n sec min hour &optional (tomorrow nil))
  (let ((todo (nth n (filter-todos-by-group todo-list selected-group))))
    (labels ((play-sound ()
               (inferior-shell:run/nil '(afplay "/Users/taggart/Downloads/light.mp3")))
             (reminder ()
               (format t "~%YOU NEED TO ~a~%" todo)
               (sb-thread:make-thread #'play-sound)))
      (if tomorrow
          (schedule-tomorrow #'reminder sec min hour)
          (schedule-today #'reminder sec min hour)))))

