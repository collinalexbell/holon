(in-package :holon)

(defun ritual (why what frequency)
  `(,why ,what ,frequency))

(defparameter *my-rituals* '())

(setf *my-rituals* (cons
                    (ritual
                     '(to have engine that can get me to 10 million views)
                     '(consult Steve)
                     '(every 20 minutes))
                    *my-rituals*))
