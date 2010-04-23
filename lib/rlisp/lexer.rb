require "strscan"

module Lisp
  class Lexer
    def tokenize(str, parser)
      s = StringScanner.new(str)
    
      while (!s.eos?)
        if s.scan(/;;.*$/)
          # ignore comments
        elsif s.scan(/\(/)
          parser << [:begin]  
        elsif s.scan(/\)/)
          parser << [:end]
        elsif number = s.scan(/\d+(\.\d+)?/)
          parser << [:number, number.to_f]
        elsif atom = s.scan(/[^\s()]+/)
          parser << [:atom, atom.to_sym]
        else
          s.getch # consume rest
        end
      end
    end
  end
end
