(in-package :task)
(ql:quickload :postmodern)
(ql:quickload :chirp)

(defun load-secrets ()
  (with-open-file (f "task/secrets")
    (let ((secrets (read f)))
      (setf chirp::*oauth-api-key*
	    (cdr (assoc 'oauth-api-key secrets)))
      (setf chirp::*oauth-api-secret*
	    (cdr (assoc 'oauth-api-secret secrets)))
      (setf chirp::*oauth-access-token*
	    (cdr (assoc 'oauth-access-token secrets)))
      (setf chirp::*oauth-access-secret*
	    (cdr (assoc 'oauth-access-secret secrets))))))

(load-secrets)


(defun save-completed-task (task)
  (multiple-value-bind (s m h d mo y) (get-decoded-time)
   (sb-thread:make-thread
    #'(lambda ()
	(chirp:statuses/update
	 (format nil "~a completed at ~d/~d/~d ~d:~d:~d"
		 (task-description task) y mo d h m s))))))
