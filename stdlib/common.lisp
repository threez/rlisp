;; Bootstap functions

(defun cadr (x) 
  (car (cdr x)))
  
(defun cdar (x)
  (cdr (car x)))
  
(defun caddr (x)
  (car (cdr (cdr x))))

(defun caar (x)
  (car (car x)))
  
(defun cadar (x)
  (car (cdr (car x))))