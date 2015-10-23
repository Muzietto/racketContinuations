#lang racket

; current continuation : -> continuation
(define (current-continuation)
  (call-with-current-continuation
    (lambda (cc) (cc cc))))

; fail-stack : list[continuation]
(define fail-stack '())

; fail : -> ...
(define (fail)
  (if (not (pair? fail-stack))
      (error "back-tracking stack exhausted!")
      (begin
        (let ((back-track-point (car fail-stack)))
          (set! fail-stack (cdr fail-stack))
                (back-track-point back-track-point)))))

; amb : list[a] -> a