(defpackage :holon.purpose
  (:use :cl :sb-ext)
  (:export :purpose-schedule-reminder))

(in-package :holon.purpose)


(defvar *current-purpose*
  (with-open-file (f (concatenate 'string
                                   (directory-namestring (user-homedir-pathname))
                                   "/Documents/current-purpose"))
    (read-line f)))


(defun purpose-schedule-reminder (&optional (every-x-mins 60))
  (flet ((alert-purpose () (holon.gui:alert *current-purpose*)))
    (schedule-timer (make-timer #'alert-purpose :name :purpose-timer)
                    0 :repeat-interval (* every-x-mins 60))))

(defun find-purpose-timer ()
  (find-if (lambda (item) (eq :purpose-timer (timer-name item)))
           (list-all-timers)))

(defun purpose-unschedule-reminder ()
  (let ((timer (find-purpose-timer)))
    (when (eq 'TIMER (type-of timer))
     (unschedule-timer timer))))
