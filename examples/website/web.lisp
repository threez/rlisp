;; Helper

(defmacro (defun) 
  (defun name parameter expr)
  (label name (lambda parameter expr)))

(defun tag (name text) (string "<" name ">" text "</" name ">"))

(defun tag_class (name class text) (
  string "<" name " class='" class "'>" text "</" name ">"))

(defun h1 (text) (tag h1 text))

(defun para (text) (tag p text))

(defun div (class text) (tag_class div class text))

(defun pre (text) (tag pre text))

(defun html (title text)
  (string
    (tag html 
      (string
        (tag head (tag "title" title))
        (tag body text)
      )
    )
  )
)

;; Website

(setq TITLE "RLISP Webserver")

(defun template (content)
  (html TITLE
    (string
      (div container content)
    )
  )
)

(defun start_page(env)
  (template
    (string 
      (h1 TITLE)
      (para "Welcome to the first rlisp site!")
      (para "It's very cool")
      (para (string (+ 23 42)))
    )  
  )
)

(defun rack_handler (env) (start_page env))
