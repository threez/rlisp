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
        elsif atom = s.scan(/[a-zA-Z0-9+\/\-*]+/)
          parser << [:atom, atom.to_sym]
        else
          s.getch # consume rest
        end
      end
    end
  end

  class List
    attr_accessor :items, :parent
  
    def initialize(parent)
      parent << self unless parent.nil?
      @parent = parent
      @items = []
    end
  
    def <<(item)
      @items << item
    end
  end

  class Parser
    attr_reader :node
    
    def initialize
      @node = List.new(nil)
    end
  
    def <<(token)
      case token.first
      when :begin
        @node = List.new(@node)
      when :end
        @node = @node.parent
      else # symbol = atom, number = float
        @node << token.last
      end
    end
  end
end
