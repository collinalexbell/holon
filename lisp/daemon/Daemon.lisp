(defpackage :holon.Daemon (:use :cl))
(in-package :holon.Daemon)

(defun Daemon (name)
  `((name . ,name)))
