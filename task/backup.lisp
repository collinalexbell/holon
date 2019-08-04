(in-package :task)

(defvar *task-id* -1)
(defparameter *task-backup-file* "task/.task.backup")

(defun backup (task)
  (setf *task-id* -1)
  (with-open-file (backup-stream
                   *task-backup-file*
                   :direction :output
                   :if-exists :supersede
                   :if-does-not-exist :create)
    (dolist (serialized-task (serialize task))
      (write-line serialized-task backup-stream))))

(defun serialize (task &optional (parent-id -1))
  (setf *task-id* (+ 1 *task-id*))
  (apply #'concatenate
         'list
         (list (serialize-1 task parent-id))
         (let ((parent-id *task-id*))
           (mapcar (lambda (task) (serialize task parent-id))
                   (inferior-holons task)))))

(defun serialize-1 (task parent-id)
  (format nil "{'id':~a, 'description':'~a', 'parent-id':~a}"
          *task-id*
          (task-description task)
          parent-id))
