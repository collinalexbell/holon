
(defpackage :youtube
  (:use :task :cl))

(defparameter todays-topic 'holon)

(defparameter all-topics '(holon fitness))

(defun next-topic ()
  (let ((next (or (cadr (member todays-topic all-topics))
		  (car all-topics))))
    (setf todays-topic next)))

(defun provoke-youtube-video-creation ()
  (let ((tasks `((make youtube video about ,todays-topic))))
    (dolist (task tasks)
      (add-task task))
    (tasks)))


(defun run ()
  (next-topic)
  (provoke-youtube-video-creation))
