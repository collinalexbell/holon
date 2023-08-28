; imperative knowledge "how to"
(in-package :holon)

;; spell
(defun procedure ()
  ;; execute the rules
  (format t "procedure ~%")
  )

;; spirit
; Talk precisely about how-to knowledge
(defun process
    (name)
    ;; create a magical spirit like entity
  `((name . ,name) (start . ,(lambda () (procedure))))
  )
;; ========================================================================================
;; ========================================================================================
;; LISP: Language designed for capturing the "spells" & "procedures"
;; ========================================================================================
;; Large systems are possible because there are techniques for controlling the complexity
;; ========================================================================================
;; Computer science sometimes "isn't real". Computer science deals with idealized components
;; ========================================================================================
;; The constraints in large software systems are the limitations of the MIND
;; ========================================================================================
;;
;;
;; Techniques
;; ========================================================================================
;; Black Box Abstraction, supress detail to go off and build bigger boxes
;;    - (sqrt x) -> ...
;;    -  + (sqrt a) (sqrt b))
;; ========================================================================================

;; (* x (+ a1 a2))

(defun add (x a1 a2)
  (* x (+ a1 a2)))

;; =========================================================================================
;; Conventional Interfaces
;; =========================================================================================
;;
;;
;; - Generic Operations
;; - Large-Scale Structue and Modularity
;; - Object-Oriented Programming
;; - Operations on Aggregates

(defun improve (x guess)
  (heron-sqrt x (/ (+ guess (/ x guess)) 2)))

(defun is-good-enough  (x guess)
  (< (abs (- x (* guess guess))) 0.1))

(defun heron-sqrt (x &optional (guess 1.0))
  (if (is-good-enough x guess)
      guess
      (improve x guess)))

(parachute:define-test t-heron-sqrt-small
  (let* ((x 16)
         (result (heron-sqrt x)))
   (parachute:true (< (abs (- x (* result result))) 0.1))))

(parachute:define-test t-heron-sqrt-large
  (let* ((x 25000)
         (result (heron-sqrt x)))
    (format t "result: ~s" result)
    (parachute:true
     (< (abs (- x (* result result))) 0.1))))

(defparameter tests
  '(t-heron-sqrt-small t-heron-sqrt-large))
(dolist (test tests) (parachute:test test))
