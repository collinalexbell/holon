(in-package :holon)


(defun how-much-negativity ()
  (format t "What level of negativity (1-5) is my thinking?~%")
  (parse-integer (read-line)))

(defun i-am-thinking-negatively (&optional level)
  (if (not level)
      (setf level (how-much-negativity)))
  (case level
    (1 '(do 10 pushups))
    (2 '(read a paragraph of think and grow rich))
    (3 '(get a coffee and read a paragraph of think and grow rich))
    (4 '(review purpose - get a coffee - and read a paragraph of think and grow rich))
    (otherwise '(review purpose - take a walk))))
