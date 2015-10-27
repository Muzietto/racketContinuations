#lang racket
; prototype of limited iterator
(define count 1)
(define counter (lambda ()
                  (cond
                    ((equal? count 5) #f)
                    (else
                     (display "hello ")
                     (display count)
                     (newline)
                     (set! count (+ count 1))
                     (counter)))))

;(counter) ; counts till 4

(define current-continuation
  (lambda () (call/cc (lambda (cc) (cc cc)))))

(let ((cc (current-continuation)))
  (cond
    ((equal? count 5) #f)
    (else
     (display "hello ")
     (display count)
     (newline)
     (set! count (+ count 1))
     (cc cc))))
