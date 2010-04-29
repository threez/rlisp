$LOAD_PATH.unshift(File.join("..", "..", "lib"))
require "rlisp"

interpreter = Lisp::Interpreter.new
interpreter.import("web.lisp")

app =lambda do |env|
  [
    200, 
    {'Content-Type' => 'text/html'}, 
    interpreter.eval([:rack_handler, env])
  ]
end

run app