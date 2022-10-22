(defpackage :holon.react (:use :cl))

(in-package :holon.react)

;; It would be wild if I did all my React programming just typing stuff at a lisp repl. I could splice in transpiled code into my existing codebase. I would keep a meta repo that has all my contributions written in lisp

(defun jsx-tag (name)
  (let ((*print-case* :downcase))
    (format nil "<~s></~s>" name name)))

(defun jsx-component (name &key children props)
                         (let ((*print-case* :capitalize))
                           (if (null children)
                               ;; opening tag
                               (if (null props)
                                   (format nil "<~s/>" name)
              ;;;
              ;;;
                                   (concatenate 'string
                                                ;;
                                                (format nil "<~s~%" name)
                                                (apply #'concatenate 'string (loop
                                                                               for prop in props collect
                                                                                                 (concatenate
                                                                                                  'string
                                                                                                  (princ-to-string "       ")
                                                                                                  (princ-to-string (car prop))
                                                                                                  (princ-to-string "={")
                                                                                                  (princ-to-string (cadr prop))
                                                                                                  (princ-to-string "}")
                                                                                                  (format nil "~%"))))
                                                (format nil "/>")))

                               (concatenate 'string
                                            (format nil "<~s>" name )
                                            (apply #'concatenate 'string (loop for child in children collect (princ-to-string child)))
                                            (format nil "</~s>" name )))))
