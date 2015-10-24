#lang scheme
; examples from http://courses.cs.washington.edu/courses/cse341/04wi/lectures/15-scheme-continuations.html

(define EMPTY '())
(define times *)
(define plus +)
(define id (lambda (x) x))
(define thrush (lambda (x) (lambda (y) (y x))))
(define begin (lambda (x) (plus 2 x)))
(define then (lambda (x) (times 4 x)))

(then (begin 1)) ; 12
(begin (then 1)) ; 6 (forget about it!)

((lambda (cont) (cont (begin 1)))(lambda (x) (times 4 x))) ; 12
((lambda (cont) (cont (begin 1))) then) ; 12
((thrush (begin 1)) then) ; 12 - thrush allows chain composition
(then (call/cc (thrush (begin 1)))) ; 12 - call/cc won't invert order of operands

(define continuation EMPTY) ; empty var
(define put-cont-in-var (lambda (cont) (set! continuation cont)))
;(define (put-cont-in-var cont) (set! continuation cont))
(define print-line (lambda(msg) (display msg)(newline)))

(print-line (call/cc put-cont-in-var)) ; call/cc returns void - only side effects matter
; you may now type (continuation "whatever") in the REPL

(continuation "Muzietto rulez")
(print-line "Muzietto rulez")

(define naive-find
  (lambda (pred x)
    (cond ((null? x) '())
          ((pred (car x)) (car x))
          (else (naive-find pred (cdr x))))))

(define (larger-than-two x) (> x 2))
(naive-find larger-than-two (list 1 2 3 4))

(define find (lambda (pred aList)
               (call/cc (lambda (cont)
                          (letrec ((helper (lambda (pred x) ; fucking 'lambda (x)' in the paper!!!!
                                             (cond ((null? x) (cont '()))
                                                   ((pred (car x)) (cont (car x)))
                                                   (else (helper pred (cdr x)))))))
                            (helper pred aList))))))

(find larger-than-two (list 0 1 2 3 4))

(define printing-naive-find
  (lambda (pred x)
    (cond ((null? x) '())
          ((pred (car x)) (car x))
          (else (let ((retval (printing-naive-find pred (cdr x))))
                  (display "returning from recursive call at: ")
                  (display (car x))
                  (newline)
                  retval)))))

(printing-naive-find larger-than-two (list 0 1 2 3 4))

(define printing-find
  (lambda (pred x)
    (call/cc
      (lambda (cont)
        (letrec ((helper
                   (lambda (pred x)
                     (cond ((null? x)      (cont '()))
                           ((pred (car x)) (cont (car x)))
                           (else (let ((retval (helper pred (cdr x))))
                                    (display "returning from call at: ")
                                    (display (car x))
                                    (newline)
                                    retval))))))
          (helper pred x))))))

(printing-find larger-than-two (list 0 1 2 3 4))
