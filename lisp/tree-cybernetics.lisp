(ql:quickload :clack)
(in-package :holon)
(import :holon.daemons)

(defun find-daemon (name)
  (find name
        (holon.daemons:products)
        :test #'(lambda (name daemon)
                  (equal name (string-downcase (string (holon.daemons:name daemon)))))))

(defun app* (req)
  (if (equal "/" (getf req :PATH-INFO))
      `(200 (:content-type "text/plain")
            (,(format nil "~a" (mapcar #'(lambda (daemon) (holon.daemons:name daemon)) (holon.daemons:products)))))
   (let* ((daemon (find-daemon(remove #\/ (getf req :PATH-INFO)))))
     (if daemon
         `(200 (:content-type "text/plain") (,(holon.daemons:print-daemon daemon)))
         '(200 (:content-type "text/plain") ("not found"))))))

(defun app (req)
  (app* req))

(defparameter server (clack:clackup #'app :port 1111))
