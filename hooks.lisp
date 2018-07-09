(ql:quickload :trivial-open-browser)

(defun hook-complete-smile (the-todo)
  (format t "Please smile~%")
  (sleep 1)
  (loop for x from 0 to 3
        do (progn (format t "~a~%" x) (sleep 1)))
  (format t "Snap!!!!!~%"))


(defun hook-select-WRITE_DOWN_GOALS (the-todo)
  (trivial-open-browser:open-browser  "https://www.deviantart.com/renny08/art/Avengers-About-Tony-Stark-303404558?offset=0"))


(defun hook-complete-WRITE_DOWN_GOALS (the-todo)
  (trivial-open-browser:open-browser  "https://www.deviantart.com/anna-kokoro/art/Cyborgs-78509781"))


(defun hook-select-WRITE_SOME_CODE (the-todo)
  (trivial-open-browser:open-browser "http://www.lispworks.com/documentation/HyperSpec/Front/"))
