module Lisp
  module Core
    def atom(a)
      !a.is_a? Array
    end
    
    def cons(*list)
      list
    end
    
    def cdr(list)
      tmp, *rest = list
      rest.empty? ? nil : rest.first
    end
    
    def car(list)
      atom(list) ? nil : list.first
    end
  end
  
  module Math
    def math_process_list(method, list)
      first, *rest = list
      rest.inject(first || 0) { |sum, i| sum = sum.send(method, i) }
    end
    
    for sign in %w(+ - * / - %) do
      eval("def #{sign}(*list)
        math_process_list(:#{sign}, list)
      end")
    end
    
    def ==(*list)
      first = list.shift
      for item in list
        return nil if !atom(item)
        return false if first != item
      end 
      true
    end

    def <(*list)
      first = list.shift
      for item in list
        return false if first >= item
        first = item
      end 
      true
    end

    def >(*list)
      first = list.shift
      for item in list
        return false if first <= item
        first = item
      end 
      true
    end
  end
end