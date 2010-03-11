require "strscan"

module Lisp
  class Lexer
    def tokenize(path, parser)
      s = StringScanner.new(File.read(path))
    
      while (!s.eos?)
        if s.scan(/;;.*$/)
          # ignore comments
        elsif s.scan(/\(/)
          parser << [:begin]  
        elsif s.scan(/\)/)
          parser << [:end]
        elsif number = s.scan(/\d+(\.\d+)?/)
          parser << [:number, number.to_f]
        elsif atom = s.scan(/[a-zA-Z0-9]+/)
          parser << [:atom, atom.to_sym]
        else
          s.getch # consume rest
        end
      end
    end
  end

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
