
(defun print-all-todo-info ()
  (print-current-todo *selected-todo*)
  (print-todo-list nil)
  (print-todo-menu))

(defgeneric print-current-todo (current-todo))

(defmethod print-current-todo ((current-todo null)))

(defmethod print-current-todo ((current-todo todo))
  (when current-todo 
    (print-todo current-todo)))

(defmethod print-current-todo ((todo-list todo-list))
  (when (.selected-todo todo-list)
    (print-todo (.selected-todo todo-list))))

(defun print-todo (selected-todo)
  (format t "~a~%~%" (todo-description selected-todo)))

(defgeneric print-todo-list (todo-list))

(defmethod print-todo-list ((todo-list todo-list)))

(defmethod print-todo-list ((todo-list null))
  (when *todo-list*
    (format t "TODO List (~a):~%" *selected-group*)
    (loop for todo in (filter-todos-by-group *todo-list* *selected-group*)
	  for i from 0 to (length *todo-list*)
	  do (format t "~a) ~dXP: ~a ~%" i
		     (todo-priority todo)
		     (todo-description todo)))))

(defun print-current-groups ()
  (format t "-----<Groups>-----~%~%")
  (let ((current-groups (current-groups)))
    (loop for group in current-groups
          for i from 0 to (length current-groups)
          do (format t "~d) ~a~%" i group)))

  (format t "~%-----</Groups>-----~%~%"))


(defun print-current-groups ()
  (format t "-----<Groups>-----~%~%")
  (let ((current-groups (current-groups)))
    (loop for group in current-groups
          for i from 0 to (length current-groups)
          do (format t "~d) ~a~%" i group)))

  (format t "~%-----</Groups>-----~%~%"))

(defun print-todo-menu ()
  (format t "~%------------------------<COMMANDS>--------------------------~%")
  (format t "SELECT <#> |    COMPLETE     | DESELECT | DELETE-SELECTED ~%")
  (format t "------------------------------------------------------------~%")
  (format t "GROUPS   | SELECT-GROUP <#>  | REMIND <#> <SEC> <MIN> <HOUR>")
  (format t "~%------------------------<COMMANDS>--------------------------~%~%"))




