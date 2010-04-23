$LOAD_PATH.unshift(File.dirname(__FILE__) + "..")
require 'lexer'
require 'parser'
require 'interpreter'

def lisp_lex(str)
  lexer = Lisp::Lexer.new
  result = Array.new
  lexer.tokenize(str, result)
  result
end

def lisp_parse(str)
  lexer = Lisp::Lexer.new
  parser = Lisp::Parser.new
  lexer.tokenize(str, parser)
  parser.node
end

def lisp_eval(str)
  interpreter = Lisp::Interpreter.new
  lisp_parse(str).map { |expr| interpreter.eval(expr) }
end