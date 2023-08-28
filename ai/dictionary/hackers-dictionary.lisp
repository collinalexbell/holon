(in-package :holon)
(ql:quickload :dexador)
(ql:quickload :lquery)
(defparameter *dict-url* "http://www.catb.org/jargon/html/go01.html")


(defun parse (response)
  (let ((doc (lquery:initialize response)))
    (lquery:$ doc "a")))
(defun request (url) (dex:get url))
(defun get-home-page ()
  (parse (request *dict-url*)))

(defun grammar (part-of-speech) (list part-of-speech))
(defun entry (word grammar) `((word . ,word) (grammar . ,grammar)))
(defun get-entry-from-home-page ())
(defun traverse-links (fn home-page))

(defun get-dict ()
  (traverse-links #'get-entry-from-home-page (get-home-page)))
