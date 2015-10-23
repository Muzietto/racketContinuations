#lang racket
;(let ((cont #f))
;  (call/cc (lambda (k)
;             (begin
;               (set! cont k))))
;  (display "ciao")
;  (cont #f))

;(+ (* 3 4) 5) k: (lambda(v) v)

(define pippo null)
(+ 1 (call/cc (lambda (k)
             (set! pippo k)
             (k (+ (* 3 4) 15)))))