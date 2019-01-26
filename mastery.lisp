
(in-package :holon)

(defun wait ()
  (read-line))

(defun execute (thing)
  (format t "I will ~a~%" thing)
  (format t "Press ENTER to continue.~%")
  (wait))

(defun gain-mastery (iteration)
  (loop for x to (- iteration 1)
	do (mastery-step)))

(defun mastery-step ()
    (learn-from-past)
    (use-thought-to-improve-future-action)
    (take-precise-action)
    (gain-experience))


(defun learn-from-past ()
  (execute '(remember relevant and salient moments))
  (execute '(reinforce positive moment causes))
  (execute '(inhibit negative moment causes))
  (execute '(make slight modifications to the moments and resimulate them mentally))
  (execute '(if the modification improves simulation result then note the modification as positive))
  (execute '(if the modification detracts from simulation result then note the modification as negative)))



(defun use-thought-to-improve-future-action ()
  (execute '(remember results of simulated action-modifications))
  (execute '(plan howto incorproate action-modifications into next-action)))

(defun take-precise-action ()
  (execute '(use all relevant thought pathways to take action as best as possible however that is defined)))

(defun gain-experience ()
  (execute '(notate and memorize all salient and relevant tidbits from the experience resulting from the previous action)))

