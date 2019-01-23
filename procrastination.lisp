
;;; Derived from 20 articles on procrastination

(defun procrastinate (human task)
  (focus human
	 (set-difference (possible-foci human)
			 (list task))))

(defun procrastination-here-is-positive? (human task)
   (or
    (super-risky? (simulate-task-risk-reward human task))
    (must-wait-on-information-generation? human task)))
