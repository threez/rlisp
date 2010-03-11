;; Addiere 2 und 2:
(p (add (div 8 2) (mult (add 2 2) (sub 10 5))))
(p (add 2 2))
(p (sub 8 (add 2 4)))
(p (mult 2 2))

;;((lambda (a b) (add a b)) 1 2)
 
;; Setze die Variable p auf den Wert 3,1415:
;;(setf p 3.1415)
 
;; Definiere eine Funktion, die ihr Argument quadriert:
;;(defun square (x)
;;  (mult x x))
 
;; Quadriere die Zahl 3:
;;(square 3)
;;(square 0.2)

;; Fibbonacci
;;(defun fib (n)
;;  (cond (lt n 2)
;;    n
;;    (add (fib (sub n 1)) 
;;         (fib (sub n 2)))))