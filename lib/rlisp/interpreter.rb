require "parser"
require "helper"
require "macros"

module Lisp
  class VariableScope
    attr_accessor :parent
    
    def initialize(parent = nil)
      @variables = {}
      @parent_scope = parent
    end
    
    def []=(variable_name, value)
      @variables[variable_name] = value
    end
    
    def [](variable_name)
      if @variables.has_key? variable_name
        @variables[variable_name]
      elsif !@parent.nil?
        @parent[variable_name]
      else
        variable_name
      end
    end
  end
  
  class Lambda
    attr_reader :scope, :body
    
    def initialize(variables, body)
      @variables = variables
      @body = body
    end
    
    def args=(args)
      @scope = VariableScope.new
      for variable_name in @variables do
        @scope[variable_name] = args.shift 
      end
    end
  end
  
  class Interpreter
    RETURN_VALUE = :_prog_return_value
    
    include Math
    include Core
    
    def initialize
      @current_scope = @global_variable_scope = VariableScope.new
      @labels = {}
      @matcher = PatternMatcher.new
    end
    
    def push_scope(scope)
      scope.parent = @current_scope
      @current_scope = scope
    end
    
    def pop_scope
      @current_scope = @current_scope.parent      
    end

    def import(path)
      lexer = Lisp::Lexer.new
      parser = Lisp::Parser.new
      path = (File.exist? path.to_s) ? path : "stdlib/#{path}.lisp"
      lexer.tokenize(File.read(path), parser)
      parser.node.each { |expr| eval(expr) }
    end
    
    def eval(expr)
      if expr.is_a? Array
        case expr.first
        when :cond
          # (cond (< 1 2) (1) (2))
          tmp, cond_expr, lt, lf = expr
          eval(cond_expr) ? eval(lt) : eval(lf)
        when :lambda
          # (lambda (x) (* x x))
          tmp, arg, body = expr
          Lambda.new(arg, body)
        when :quote  
          tmp, quoted = expr
          quoted
        when :label
          # (label blah (lambda (x) (* x x)))
          tmp, fn, the_lambda = expr
          @labels[fn] = eval(the_lambda)
        when :setq
          # (setq name value)
          tmp, name, value = expr
          @global_variable_scope[name] = value
        when :let
          # (let name value)
          tmp, name, value = expr
          @current_scope[name] = value
        when :return
          # (return value)
          tmp, value = expr
          @current_scope[RETURN_VALUE] = eval(value)
        when :prog
          # (prog (exp1) (exp2) ... (exprN))
          tmp, *expressions = expr
          program_scope = VariableScope.new
          push_scope(program_scope)
          expressions.each { |expr| eval(expr) }
          evaled = program_scope[RETURN_VALUE]
          pop_scope
          evaled
        when :defmacro
          # (defmacro (keyword1 ... keywordN) (pattern) (transformation))
          tmp, keywords, pattern, transformation = expr
          @matcher.create_macro!(keywords, pattern, transformation)
        when nil
          false
        else
          if macro = @matcher[expr]
            eval(macro.apply(expr))
          else
            e = expr.map do |i|
              eval(i)
            end
            apply(e)
          end
        end
      elsif expr.is_a? Symbol
        value = @current_scope[expr]
        if value.is_a? Array
          eval(value)
        else
          value
        end
      else
        expr
      end
    end
    
    def apply(expr)
      fn, *rest = expr
      
      # search for lambda of function name
      fn = @labels[fn] if @labels[fn]
      
      if fn.is_a? Lambda
        fn.args = rest
        push_scope(fn.scope)
        evaled = eval(fn.body)
        pop_scope
        evaled
      else
        self.send(fn, *rest)
      end
    end
  end
end