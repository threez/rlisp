(import common)

;; Addiere 2 und 2:
(p (add (div 8 2) (mult (add 2 2) (sub 10 5))))
(p (add 2 2))
(p (sub 8 (add 2 4)))
(p (mult 2 2))

;; lambda & label
(p ((lambda (x) (mult x x)) 5))

(label test (lambda (a b) (add a b)))

(p (test 10 20))

(p ((lambda (a b) (add a b)) 1 2))

(p ((lambda (a b) ((lambda (a b) (add a b)) a b)) 1 2))
 
;; Setze die Variable p auf den Wert 3,1415:
(setq pi 3.1415)
 
;; Definiere eine Funktion, die ihr Argument quadriert:
(defun square (x)
  (mult x x))
 
;; Quadriere die Zahl 3:
(square 3)
(p (square pi))

;; Fibbonacci
(defun fib (n)
  (cond (lt n 2)
    n
    (add (fib (sub n 1)) 
         (fib (sub n 2)))))
         
(p (fib 0))
(p (fib 1))
(p (fib 2))
(p (fib 3))
(p (fib 5))
(p (fib 6))
(p (fib 10))
(p (fib 15))
(p (fib 20))
         
(p (cond (gt 1 2) (quote T) (quote ())))