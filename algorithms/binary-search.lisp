(load "~/.sbclrc")
(load "~/quicklisp/setup.lisp")
(ql:quickload :parachute)

(in-package :holon)
;; anyone know how to run this only when sbcl is not in --script mode?

(defun binary-search (l needle &optional lower upper)
  (let ((v (coerce l 'vector)))
   (let ((lower (if (null lower) 0 lower))
         (upper (if (null upper) (length l) upper)))
     (if ( <= (- upper lower) 1)
         ;;base
         (if (eql (aref v lower) needle)
             lower
             ;; else magic
             -424242)

                                        ;main case
         (let ((pivot (+ (floor (/ (- upper lower) 2)) lower)))
           (if (< needle (aref v pivot))
               (binary-search v needle lower pivot)
               (binary-search v needle pivot upper)))))))


;; binary search needs sorted data duh

(parachute:define-test binary-search-basic
  (parachute:true (eql 8 (binary-search '(0 3 7 18 23 44 55 67 88 90 102 145 177 200 300 400 456 567 555) 88))))

(parachute:test 'binary-search-basic)
