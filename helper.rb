module Lisp
  module Core
    def car(list)
      list.first
    end
    
    def cdr(list)
      list.slice(1, list.size)
    end
    
    def cons(a, list)
      [a, list]
    end
    
    def atom(a)
      !a.is_a?(Array)
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