#lang racket

(let ((a 1)) (display a))

(let ((a 1)
      (b 2))
  (display (+ a b))
  (newline)
  (display b))

(let* ((a "birillo 123")
       (pippo (lambda () a))
       (b (pippo)))
  (newline)
  (display b))

(define alfa 234)
(display alfa)


(define beta (lambda () 345))
(define gamma (beta))
(display gamma)

(set! alfa (+ alfa 1))
(cond
   ((equal? alfa 234) (newline) (display alfa))
   ((equal? alfa 235) (newline) (display "xxxxxxxx"))
   (else               (error "Contract violation!")))