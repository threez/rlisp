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

; Sequenzielle Programmierung
(p (prog (setq a (* 2 3)) (setq b (* 3 4)) (return (+ a b))))

; weitere Tests

(puts (+ (* 10 4) 2))
(cond (< 10 42) (puts ja) (puts nein))
(setq x 5)
(p ((lambda (x) (* x x)) x))
(label square (lambda (x) (* x x)))
(p (square 5))
(defun add (a b) (+ a b))
(p (add 1 2))
(p ((lambda (x) ((lambda (x) (* x x)) x)) 10))
(setq a 20)
(p ((lambda (x) ((lambda (x) (* a x)) x)) 10))
(p xx)
(setq a (* 2 3))
(p (* a 4))
(p (quote (+ 2 3 4)))
(p (cons (list a b) (list c d)))

; tests macros

(defmacro (print aa)
  (print aa list)
  (aa list))

(defmacro (print bb)
  (print bb list)
  (bb list))

(defun aa (list) (p fa list))

(defun bb (list) (p fb list))

(print aa (quote x y z))

(print bb (quote x y z))