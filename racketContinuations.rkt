#lang typed/racket/no-check

;(define (atom? x) (not (or (pair? x) (null? x))))

(define sum-list
  (lambda (l k)
        (cond
      [(empty? l) (k 0)]
      [(number? (car l)) (sum-list (cdr l) (lambda (x)(k (+ x (car l)))))]
      [else (sum-list (car l) (lambda (ax)(sum-list (cdr l) (lambda(x)(k (+ x ax))))))]
    )
  )
)

(define doubler (lambda(x)(* 2 x)))


;(check-expect (sum-list (list 1 3 4 2) doubler) 20)
;(check-expect (sum-list (list  (list 3 4) 1 2) doubler) 20)
;(check-expect (sum-list (list 6 (list 3 (list 4)) 1 (list 1 2 (list 4 (list 1 3 (list (list 1 2) 6)) 2))) doubler) 72)

(define b 12)
(define a 13)

(assert (< b a))

