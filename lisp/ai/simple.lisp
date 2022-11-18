(in-package :holon)
;36 A SIMPLE LISP PROGRAM
(defun one-of ( set )
  "Pick one element of set , and make alist of i t . "
  (list (random-elt set ) ) )
(defun random-elt (choices)
  "Choose an element from alist at random."
  ( elt choices (random (length choices ))))
(defun sentence () (append (noun-phrase) ( verb-phrase ) ) )
(defun noun-phrase () (append (  Article ) (Noun)))
(defun verb-phrase () (append (Verb) (noun-phrase)))
(defun  Article () (one-of ' (  the a ) ) )
(defun Noun () (one-of '(man ball woman table ) ) )
(defun Verb () (one-of ' ( hit took saw liked ) ) )


