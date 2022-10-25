(ql:quickload :clack)
(in-package :holon)
(import :holon.daemons)


(defparameter *tree-cybernetics* (let (( tree-inc (make-instance 'Corporation)))
                                   ;; initialize tree cybernetics here
                                   (setf (slot-value tree-inc 'share-holders) 'kuberlog)
                                   (setf (slot-value tree-inc 'urls) '())
                                   (setf (slot-value tree-inc 'urls) (holon.daemons:products))
                                   (setf (slot-value tree-inc 'services) '((code explainations)))
                                   (setf (slot-value tree-inc 'customers) '())
                                   tree-inc))


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
