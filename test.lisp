;; Addiere 2 und 2:
(+ 2 2)
 
;; Setze die Variable p auf den Wert 3,1415:
(setf p 3.1415)
 
;; Definiere eine Funktion, die ihr Argument quadriert:
(defun square (x)
  (* x x))
 
;; Quadriere die Zahl 3:
(square 3)
(square 0.2)

;; Fibbonacci
(defun fib (n)
  (if (< n 2)
    n
    (+ (fib (- n 1)) (fib (- n 2)))))