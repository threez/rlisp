require "lexer"

module Lisp
  class Parser
    attr_reader :node
  
    def initialize
      @stack = []
      @node = []
    end

    def <<(token)
      case token.first
      when :begin
        tmp = []
        @stack.push(@node)
        @node << tmp
        @node = tmp
      when :end
        @node = @stack.pop
      else # symbol = atom, number = float
        @node << token.last
      end
    end
  end
end
