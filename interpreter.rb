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
      !a.is_a?(Array)
    end
  end
  
  module Math
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
    include Math
    
    DEBUG = ENV["VERBOSE"]
    
    def initialize
      @functions = {}
      @variables = {:T => true, :F => false}
    end
    
    def add_function(fn, expr)
      tmp, *rest = expr
      @functions[fn] = rest
      p @functions if DEBUG
    end
    
    def label(fn, expr)
      @functions[fn] = @functions[expr]
      p @functions if DEBUG
    end
    
    def setq(name, value)
      @variables[name] = value
      p @variables if DEBUG
    end
    
    def import(file)
      lexer = Lisp::Lexer.new
      parser = Lisp::Parser.new
      lexer.tokenize("stdlib/#{file}.lisp", parser)
      for expr in parser.node
        eval(expr)
      end
    end
    
    def eval(expr, indent = 0)
      if expr.is_a?(Array)
        case expr.first 
        when :lambda
          puts "#{'  ' * indent}eval-lambda: #{expr.inspect}" if DEBUG
          name = "lambda.#{Time.now.to_f}".gsub(".", "_").to_sym
          self.add_function(name, expr)
          name
        when :defun
          tmp, name, *rest = expr
          puts "#{'  ' * indent}eval-defun: #{expr.inspect}" if DEBUG
          @functions[name] = rest
          nil
        when :quote
          tmp, *rest = expr
          rest
        when :cond
          tmp, condition, l1, l2 = expr
          if eval(condition, indent) == true
            eval(l1, indent + 1)
          else
            eval(l2, indent + 1)
          end
        else
          puts "#{'  ' * indent}eval: #{expr.inspect}" if DEBUG
          e = expr.map do |item|
            eval(item, indent + 1)
          end
          apply(e, indent + 1)
        end
      else
        puts "#{'  ' * indent}atom: #{expr.inspect}" if DEBUG
        @variables[expr] ? @variables[expr] : expr
      end
    end
    
    def replace(search_atom, new_atom, expr)
      expr.map do |item|
        if item.is_a? Array
          replace(search_atom, new_atom, item)
        else
          (search_atom == item) ? new_atom : item
        end
      end
    end
    
    def apply(expr, indent = 0)
      fn, *rest = expr
      puts "#{'  ' * indent}apply: #{expr.inspect}" if DEBUG
      if func = @functions[fn]
        fexpr = func.last
        func.first.each_with_index do |param, i|
          fexpr = replace(param, rest[i], fexpr)
        end
        e = eval(fexpr, indent + 1)
      else
        e = self.send(fn, *rest)
      end
      puts "#{'  ' * indent}`--> #{e.inspect}" if DEBUG
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