
(defun print-all-task-info ()
  (print-current-task *selected-task*)
  (print-task-list nil)
  (print-task-menu))

(defgeneric print-current-task (current-task))

(defmethod print-current-task ((current-task null)))

(defmethod print-current-task ((current-task task))
  (when current-task 
    (print-task current-task)))

(defmethod print-current-task ((task-list task-list))
  (when (.selected-task task-list)
    (print-task (.selected-task task-list))))

(defun print-task (selected-task)
  (format t "~a~%~%" (task-description selected-task)))

(defgeneric print-task-list (task-list))

(defmethod print-task-list ((task-list task-list)))

(defmethod print-task-list ((task-list null))
  (when *task-list*
    (format t "TASK List (~a):~%" *selected-group*)
    (loop for task in (filter-tasks-by-group *task-list* *selected-group*)
	  for i from 0 to (length *task-list*)
	  do (format t "~a) ~dXP: ~a ~%" i
		     (task-priority task)
		     (task-description task)))))

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

(defun print-task-menu ()
  (format t "~%------------------------<COMMANDS>--------------------------~%")
  (format t "SELECT <#> |    COMPLETE     | DESELECT | DELETE-SELECTED ~%")
  (format t "------------------------------------------------------------~%")
  (format t "GROUPS   | SELECT-GROUP <#>  | REMIND <#> <SEC> <MIN> <HOUR>")
  (format t "~%------------------------<COMMANDS>--------------------------~%~%"))




