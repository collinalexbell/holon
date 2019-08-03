(in-package :holon)

(defparameter encouragements
  '((you got this bro)
    (nothing can stop you)
    (work like a machine)
    (win win win)
    (keep fighting)
    (just keep going)
    (dont quit)
    (you can do this)))

(defparameter *encourage* t)
(defparameter encourage-every-x-min 10)

(defun random-elt (l)
  (elt l (random (length l))))

(defun encourage ()
  (format t "~a~%"
	  (random-elt encouragements)))

(defun attempt-encouragement-timer-start ()
  (when *encourage*
    (sb-ext::schedule-timer
     (sb-ext::make-timer #'(lambda ()
			     (encourage)
			     (attempt-encouragement-timer-start)
			     (sb-ext:run-program "/bin/play"
						 '("sounds/beep.mp3"))))
     (* 60 encourage-every-x-min))))

(defun start-encouragement-cycle ()
  (setf *encourage* t)
  (attempt-encouragement-timer-start))

(defun stop-encouragement-cycle ()
  (setf *encourage* nil))
