(in-package :holon)

(defun pomodoro (time-in-minutes number-of-tasks)
  (let ((meditate-time (* time-in-minutes 0.03))
        (mastery-time (* time-in-minutes 0.05))
        (per-task-time (* time-in-minutes (/ 0.8 number-of-tasks)))
        (rest-time (* time-in-minutes (- 1 0.03 0.05 0.8))))

    (let ((instructions
            `((("Meditate for ~a minutes~%"
                ,meditate-time)
               ,meditate-time)

              (("Do mastery for ~a minutes~%"
                ,mastery-time)
               ,mastery-time)

              ,@(loop
                for i from 1 to number-of-tasks
                collect
                `(("Do ~a out of ~a tasks for ~a minutes~%"
                   ,i ,number-of-tasks ,per-task-time)
                  ,per-task-time))

              (("Take a rest for ~a minutes~%"
                ,rest-time)
               ,rest-time))))
     (loop
       for instruction in instructions
       do (apply #'msg-sleep-and-ping instruction)))))


(defun msg-sleep-and-ping (msg mins-to-sleep)
  (apply #'format t msg)
  (sleep-mins mins-to-sleep)
  (sb-ext:run-program "/usr/bin/aplay" '("resources/r2d2.wav")))

(defun sleep-mins (mins)
  (sleep (* mins 60)))
