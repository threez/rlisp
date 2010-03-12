require 'interpreter'
require 'readline'

interpreter = Lisp::Interpreter.new
lexer = Lisp::Lexer.new
$quit = false

def interpreter.exit
  $quit = true
end

while !$quit && (line = Readline.readline('> ', true))
  parser = Lisp::Parser.new
  lexer.tokenize(line, parser)
  begin
    puts interpreter.eval(parser.node.first)
  rescue => ex
    puts "Error: #{ex}"
  end
end