
(defpackage :youtube
  (:use :holon.task :cl))
(in-package :youtube)

(defparameter todays-topic 'holon)

(defparameter all-topics
  '(holon
    politics
    math
    physics
    gardening
    outdoor-sports
    cybernetics
    robotics
    programming
    entrepreneurship
    vlog))

(defun next-topic ()
  (let ((next (or (cadr (member todays-topic all-topics))
		  (car all-topics))))
    (setf todays-topic next)))

(defun provoke-youtube-video-creation ()
  (let ((tasks `((make youtube video about ,todays-topic))))
    (dolist (task tasks)
      (add-task task))
    (tasks)))


(defun run (x)
  (loop repeat x
        do (progn (next-topic)
                  (provoke-youtube-video-creation))))
