require "lexer"

module Lisp
  module Core
    def car(list)
      list.first
    end
    
    def cdr(list)
      list.slice(1, list.size)
    end
    
    def eq(a1, a2)
      a1 == a2
    end
    
    def cons(a, list)
      [a, list]
    end
    
    def atom(a)
      a.is_a?(Symbol)
    end
    
    def add(a, b)
      a + b
    end
    
    def mult(a, b)
      a * b
    end
    
    def div(a, b)
      a / b
    end
    
    def sub(a, b)
      a - b
    end
    
    def mod(a, b)
      a % b
    end
    
    def lt(a, b)
      a < b
    end
    
    def gt(a, b)
      a > b
    end
    
  end

  class Interpreter
    include Core
    
    def eval(expr, indent = 0)
      if expr.is_a? Array
        puts "#{'  ' * indent}eval: #{expr.inspect}"
        e = expr.map do |item|
          eval(item, indent + 1)
        end
        apply(e, indent + 1)
      else
        puts "#{'  ' * indent}atom: #{expr.inspect}"
        expr
      end
    end
    
    def apply(expr, indent = 0)
      fn, *rest = expr
      e = self.send(fn, *rest)
      puts "#{'  ' * indent}apply: #{expr.inspect} --> #{e}"
      e
    end
  end
end

l = Lisp::Lexer.new
p = Lisp::Parser.new
l.tokenize("test.lisp", p)
i = Lisp::Interpreter.new
for expr in p.node
  i.eval(expr)
end