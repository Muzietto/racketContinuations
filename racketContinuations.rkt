#lang typed/racket/no-check
(require test-engine/racket-gui)

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


(check-expect (sum-list (list 1 3 4 2 8) doubler) 210)
(check-expect (sum-list (list  (list 3 4) 1 2) doubler) 20)
(check-expect (sum-list (list 6 (list 3 (list 4)) 1 (list 1 2 (list 4 (list 1 3 (list (list 1 2) 6)) 2))) doubler) 72)

;(define b 12)
;(define a 13)

;(let (a (amb (list 1 2 3 4 5 6 7)))
;      (b (amb (list 1 2 3 4 5 6 7)))
;      (c (amb (list 1 2 3 4 5 6 7))))



(display
  (call-with-current-continuation (lambda (cc)
            (display "I got here.\n")
            (cc "This string was passed to the continuation.\n")
            (display "But not here.\n"))))

(let ([a 13]
      [b 12])
(assert (< b a)))

(let fac ([n 10])
    (if (zero? n)
        1
        (* n (fac (sub1 n))))
  ;(display "pippo")
  )

(let ([start #t][count 5]) ; put [start #f] to run all this
  
  (if (not start)
  (begin 
    ;(display "outside ")
    (call/cc (lambda (cc)
               (display "inside ")
               (set! start cc)))
    ;(display "afterside ")
    ;(display "finally! ")
    )
      #f)
  (if (> count 0)
      (set! count (- count 1))
      (set! start #f))
  (display count)
  (display " - going to invoke (start)\n")
  ;(start) ; uncomment this
  )

(define (current-continuation)
  (call/cc (lambda(cc)(cc cc))))

