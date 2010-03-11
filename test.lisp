(import common)

;; Addiere 2 und 2:
(p (+ (/ 8 2) (* (+ 2 2) (- 10 5))))
(p (+ 2 2))
(p (- 8 (+ 2 4)))
(p (* 2 2))

;; lambda & label
(p ((lambda (x) (* x x)) 5))

(label test (lambda (a b) (+ a b)))

(p (test 10 20))

(p ((lambda (a b) (+ a b)) 1 2))

(p ((lambda (a b) ((lambda (a b) (+ a b)) a b)) 1 2))
 
;; Setze die Variable p auf den Wert 3,1415:
(setq pi 3.1415)
 
;; Definiere eine Funktion, die ihr Argument quadriert:
(defun square (x)
  (* x x))
 
;; Quadriere die Zahl 3:
(square 3)
(p (square pi))

;; Fibbonacci
(defun fib (n)
  (cond (< n 2)
    n
    (+ (fib (- n 1)) 
         (fib (- n 2)))))
         
(p (fib 0))
(p (fib 1))
(p (fib 2))
(p (fib 3))
(p (fib 5))
(p (fib 6))
(p (fib 10))
(p (fib 15))
(p (fib 20))
         
(p (cond (> 1 2) (quote T) (quote ())))

(print Hello World)