module Lisp
  module Core
    def atom(a)
      !a.is_a? Array
    end
    
    def cons(a, list)
      [a, list]
    end
    
    def cdr(list)
      tmp, *rest = list
      rest
    end
    
    def car(list)
      list.first
    end
    
    def list(*items)
      items    
    end
  end
  
  module Math
    def math_process_list(method, list)
      first, *rest = list
      rest.inject(first || 0) { |sum, i| sum = sum.send(method, i) }
    end
    
    for sign in %w(+ - * / - % < > ==) do
      eval("def #{sign}(*list)
        math_process_list(:#{sign}, list)
      end")
    end
  end
end