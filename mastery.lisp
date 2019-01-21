
(in-package :holon)

(defun execute (thing)
  (format t "I will ~a~%" thing))

(defun mastery ()
  (loop
    (learn-from-past)
    (use-thought-to-improve-future-action)
    (take-precise-action)
    (gain-experience)))


(defun learn-from-past ()
  (execute '(remember relevant and salient moments))
  (execute '(make slight modifications to the moments and resimulate them mentally))
  (execute '(if the modification improves simulation result then note the modification as positive))
  (execute '(if the modification detracts from simulation result then note the modification as negative)))



