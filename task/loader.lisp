(in-package :holon.task)

(defun gen-fname (task-symbol)
  (concatenate 'string
	       "task/resources/"
	       (string-downcase (symbol-name task-symbol))
	       ".tasks"))

(defun load-tasks (task-symbol)
  (with-open-file (f (gen-fname task-symbol) :direction :input)
    (loop for task in (read f)
	  do (add-task task :priority 9001 :task-groups '(templated))))
  (tasks))

