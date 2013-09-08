;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname closest-linear) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))

(check-expect (closest-linear (list 1)) empty)
(check-expect (closest-linear (list 1 2)) (list 1 2))
(check-expect (closest-linear (list -5 1 2)) (list 1 2))
(check-expect (closest-linear (list -5 1 2 15)) (list 1 2))
(check-expect (closest-linear (list 2 -5 1)) (list 1 2))
(check-expect (closest-linear (list 1 13 4 12)) (list 12 13))

(define closest-linear
  (lambda (alist)
    (closest-pair (mergesort alist) empty empty)))

(define closest-pair
  (lambda (alist last-x best-pair)
    (cond
      [(empty? alist) best-pair]
      [(empty? last-x) (closest-pair (cdr alist) (car alist) best-pair)]
      [(empty? best-pair) (closest-pair (cdr alist) (car alist) (list last-x (car alist)))]
      [(< (distance-between (list last-x (car alist))) (distance-between best-pair)) (closest-pair (cdr alist) (car alist) (list last-x (car alist)))]
      [else (closest-pair (cdr alist) (car alist) best-pair)])
    )
  )

(check-expect (distance-between (list 1 2)) 1)
(check-expect (distance-between (list -1 2)) 3)
(check-expect (distance-between (list -11 -2)) 9)
(check-expect (distance-between (list 1 22)) 21)

(define distance-between
  (lambda (pair)
    (- (cadr pair) (car pair))))

(define mergesort 
  (lambda (alist) 
    (cond 
      [(= (length alist) 1) alist]
      [(= (length alist) 2) 
       (cond
         [(< (car alist) (cadr alist)) alist]
         [else (cons (cadr alist) (list (car alist)))]
        )]
      [else (merge (mergesort (1st-half alist)) (mergesort (2nd-half alist)))]
     )
  )
)

(define merge
  (lambda (alist blist)
    (cond 
      [(empty? alist) blist]
      [(empty? blist) alist]
      [(< (car alist) (car blist)) (cons (car alist) (merge (cdr alist) blist))]
      [else (cons (car blist) (merge alist (cdr blist)))]
     )
    )
  )

; middle-index of a list --> floor(length/2)
(define middle-index
  (lambda (list) 
    (floor (/ (length list) 2))
  )
)

; get n-th element from a list
(define get
  (lambda (alist index)
    (cond 
      [(empty? alist) empty]
      [(= index 0) (car alist)]
      [else (get (cdr alist) (- index 1))]
      )
    )
  )

; middle-element of a list
(define middle-element
  (lambda (alist)
    (get alist (middle-index alist))
    )
  )

; first part of a list until given element
(define list-until
  (lambda (alist element)
    (lu-helper alist element empty)
    )
  )
; begin helper method
(define lu-helper 
  (lambda (alist element acc)
    (cond
      [(empty? alist) (reverse acc)]
      [(equal? (car alist) element) (reverse acc)]
      [else (lu-helper (cdr alist) element (cons (car alist) acc))]
      )
    )
  )
; end helper method

; last part of a list after given element
(define list-after
  (lambda (alist element)
    (cond
      [(empty? alist) empty]
      [(equal? (car alist) element) (cdr alist)]
      [else (list-after (cdr alist) element)]
      )
    )
  )

; first half of a list (floors if oneven length)
(define 1st-half
  (lambda (alist)
    (list-until alist (middle-element alist))
    )
  )

; second half of a list (rounds up if oneven length)
(define 2nd-half
  (lambda (alist)
    (cons (middle-element alist) (list-after alist (middle-element alist)))
    )
  )
