
;;; Derived from 20 articles on procrastination

(defun procrastinate (human task)
  (focus human
	 (set-difference (possible-foci human)
			 (list task))))
