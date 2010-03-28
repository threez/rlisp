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
    def +(a, b)
      a + b
    end
    
    def *(a, b)
      a * b
    end
    
    def /(a, b)
      a / b
    end
    
    def -(a, b)
      a - b
    end
    
    def %(a, b)
      a % b
    end
    
    def <(a, b)
      a < b
    end
    
    def >(a, b)
      a > b
    end
    
    def eq(a, b)
      a == b
    end
  end
end