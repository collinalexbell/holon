(in-package :task)
(defparameter *saved-task-backend* 'none)
(defparameter *root-task* (new-task '(will goodness)
				    0
				    '()
				    nil))
(defparameter *selected-task* *root-task*)
(defparameter *selected-group* 'all)
(defparameter *global-save-file* "current.task-list")
(defparameter *global-group-file* "groups.list")

