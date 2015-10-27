#lang racket
;http://matt.might.net/articles/programming-with-continuations--exceptions-backtracking-search-threads-generators-coroutines/

;(define (current-continuation)
;  (call/cc (lambda (cc) (cc cc))))

(define current-continuation
  (lambda () (call/cc (lambda (cc) (cc cc)))))

(let ((cc (current-continuation))
      (alfa 123))
  "whatever1")

; gonna blow
;(let ((cc ((lambda () (current-continuation))))
;      (beta 234))
;  (display "whatever2")
;  (cc cc))

(define (right-now) 
  (call-with-current-continuation
    (lambda (cc)
      (cc cc))))

(define right-now2 (lambda () 
  (call-with-current-continuation
    (lambda (cc)
      (cc cc)))))

(define (go-when then)
  (then then))

;(let ((the-beginning (right-now)))
;  (display "Hello, world!")
;  (newline)
;  (go-when the-beginning))

;(let ((the-beginning (right-now)))
;  (display "Hello, world!")
;  (newline)
;  (the-beginning the-beginning))

;(let ((the-beginning (call-with-current-continuation (lambda (cc) (cc cc)))))
;  (display "Hello, world!")
;  (newline)
;  (the-beginning the-beginning))
