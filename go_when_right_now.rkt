#lang racket
;http://matt.might.net/articles/programming-with-continuations--exceptions-backtracking-search-threads-generators-coroutines/

(define (right-now)
  (call-with-current-continuation
    (lambda (cc)
      (cc cc))))

(define (go-when then)
  (then then))

(let ((the-beginning (right-now)))
  (display "Hello, world!")
  (newline)
  (go-when the-beginning))