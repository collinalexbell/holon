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


(defun management ()
  (execute
   '(become aware of habits and thoughts that lead to procrastination)
   '(seek help on self-defeating problems)
   '(evaluate oneself fairly and honestly)
   '(set realistic goals)
   '(restructure daily activities)
   '(modify environment to eliminate distractions)
   '(set priorities)
   '(use enjoyable activities as motivation)
   '(use time blocking)))
