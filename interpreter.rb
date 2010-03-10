require "lexer"

l = Lisp::Lexer.new()
p = Lisp::Parser.new()
l.tokenize("test.lisp", p)
require "pp"
pp p.node