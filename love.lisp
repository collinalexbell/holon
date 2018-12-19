(in-package :holon)

(defun love-myself ()
  (grow-patience-for 'I)
  (grow-kindness-for 'I)
  (grow-truthfulness-about 'I)
  (grow-trust-for 'I)
  (grow-perserverence-for 'I))

(defun wait-on-user ()
  (read-line))

(defun grow-patience-for (holon)
  (format
   t
   "Write down 1 action that can be taken to become more patient with ~a~%"
   holon)
  (wait-on-user))


(defun grow-kindness-for (holon)
  (format
   t
   "What is 1 thing I can do to be more kind to ~a. Write it down~%"
   holon)
  (wait-on-user))

(defun grow-truthfulness-about (holon)
  (format
   t
   "What can I study about ~a to be more understanding~%"
   holon)
  (wait-on-user))


(defun grow-trust-for (holon)
  (format
   t
   "What changes can I make to be more trustful about ~a~%"
   holon)
  (wait-on-user))

(defun grow-perserverence-for (holon)
  (format
   t
   "What small action can I do to perservere in love for ~a~%"
   holon)
  (wait-on-user))
