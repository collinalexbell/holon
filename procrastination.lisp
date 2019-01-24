
;;; Derived from 20 articles on procrastination

(defun procrastinate (human task)
  (focus human (best-coping-response)))

(defun procrastination-here-is-positive? (human task)
   (or
    (super-risky? (simulate-task-risk-reward human task))
    (must-wait-on-information-generation? human task)))


(defun procrastination-likelyhood (human task)
  (count-if
   #'identity
   `(,(procrastination-here-is-positive? human task)
     ,(perception-that-recent--performance-cant-be-replicated-today? human)
     ,(human-may-look-incompetent-doing-task? human task))))

(defvar *coping-responses*
  '(avoidance
    denial
    distraction
    valorisation
    blaming
    humor))

(defun best-coping-response ()
  (nth (random (length *coping-responses*)) *coping-responses*))
