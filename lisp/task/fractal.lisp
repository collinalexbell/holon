; code won't work until #'select operates on task objects
; won't work until #'add-task returns task obj


;; Adds 10 '(post to insta) tasks each with an increasing number of sub tasks
(defun spiral ()
  (loop for n from 1 to 10
        do
           (let ((task (add-task '(post to insta))))
             (select task)
             (loop for i from 1 to n
                   do
                      (add-task '(take a step in holon work))))))
