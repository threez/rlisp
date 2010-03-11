require "lexer"
require "helper"

module Lisp
  class Interpreter
    include Core
    include Math
    
    def initialize
      @functions = {}
      @variables = {}
    end
    
    def label(fn, expr)
      @functions[fn] = @functions[expr]
    end
    
    def setq(name, value)
      @variables[name] = value
    end
    
    def import(file)
      lexer = Lisp::Lexer.new
      parser = Lisp::Parser.new
      lexer.tokenize("stdlib/#{file}.lisp", parser)
      start(parser.node)
    end
    
    def start(expressions)
      expressions.each { |expr| eval(expr) }
    end
    
    def eval(expr)
      if expr.is_a? Array
        case expr.first 
        when :lambda  
          tmp, *rest = expr
          name = "lambda.#{Time.now.to_f}".gsub(".", "_").to_sym
          @functions[name] = rest
          name
        when :defun
          tmp, name, *rest = expr
          @functions[name] = rest
        when :quote
          tmp, *rest = expr
          rest
        when :cond
          tmp, condition, l1, l2 = expr
          eval(condition) ? eval(l1) : eval(l2)
        else
          apply expr.map { |i| eval(i) }
        end
      else
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
    
    def apply(expr)
      fn, *rest = expr
      if func = @functions[fn]
        params, definition = func
        params.each_with_index do |param, i|
          definition = replace(param, rest[i], definition)
        end
        eval(definition)
      else
        self.send(fn, *rest)
      end
    end
  end
end

l = Lisp::Lexer.new
p = Lisp::Parser.new
l.tokenize("test.lisp", p)
i = Lisp::Interpreter.new
i.start p.node