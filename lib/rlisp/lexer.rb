require "strscan"

module Lisp
  class Lexer
    def tokenize(str, parser)
      s = StringScanner.new(str)
    
      while (!s.eos?)
        if s.scan(/;;.*$/)
          # ignore comments
        elsif s.scan(/"/)
          string = ""
          while (!s.eos?)
            if s.scan(/\\"/)
              string << '"'
            elsif s.scan(/"/)
              break
            else
              string << s.getch
            end
          end
          parser << [:string, string]
        elsif s.scan(/\(/)
          parser << [:begin]  
        elsif s.scan(/\)/)
          parser << [:end]
        elsif number = s.scan(/[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?/)
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
