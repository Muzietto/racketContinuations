#lang racket
; this is an endless loop!!
;(let ((cont #f))
;  (call/cc (lambda (k)
;             (begin
;               (set! cont k))))
;  (display "ciao")
;  (cont #f))


(define pippo null)
(+ 1 (call/cc (lambda (k)
             (set! pippo k) ; allows (pippo 3) -> 4 afterwards
             (k (+ (* 3 4) 15)))) ; returns 27
   ) ; returns 28 to the repl

(set! pippo null)
(+ 1 (call/cc (lambda(cc)
                (set! pippo cc) ; allows (pippo 3) -> 4 afterwards
                2)) ; returns 2!!!!!!!
   ) ; returns 3 to the repl

(set! pippo null)
(+ 1 (call/cc (lambda(cc)
                (set! pippo cc) ; allows (pippo 3) -> 4 afterwards
                (cc 8) ; returns 8
                2))
   ) ; returns 9 to the repl

; from https://www.youtube.com/watch?v=2GfFlfToBCo
; x gets bound to the return value of call/cc
(let ([x (call/cc (lambda (k) k))])
  ; in this case call/cc plainly returns its own continuation
  ; that means that lambda(ignore) gets executed
  (x (lambda (ignore) "hi"))) ; and it returns "hi"

; from https://www.youtube.com/watch?v=2GfFlfToBCo
; here we must trust that the continuation of call/cc(id)
; is id, and it does not entail "HEY!"
(( (call/cc (lambda (k) k))
 (lambda (x) x)) "HEY!")

; ((id id) "HEY!") = "HEY!"
(((lambda (x) x)(lambda (x) x)) "HEY!")

; from https://www.youtube.com/watch?v=2GfFlfToBCo
(call/cc
  (lambda (k)
    (+ 1 (k 2) 3)))

; from https://www.youtube.com/watch?v=2GfFlfToBCo
(+ (call/cc 
	(lambda (k)
		(k (* 3 4))))
	5 )

; trying something...
(define id (lambda (x) x))
(define thrush (lambda (arg) (lambda (x) (x arg))))
(define then (lambda (x) (+ x 5)))
(define begin (lambda (x) (* x 4)))

(then (begin 3)) ; that's 17
(then (call/cc (thrush (begin 3)))) ; that's 17 again

(define anything 12)
(equal? (call/cc (thrush anything)) anything)
