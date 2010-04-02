module Lisp
  class Macro
    attr_reader :keywords, :pattern, :transformation
    
    def initialize(keywords, pattern, transformation)
      @keywords = keywords
      @pattern = pattern
      @transformation = transformation
      @pattern_list = {}
      @pattern.each_with_index do |elem, i|
        @pattern_list[i] = elem if @keywords.include? elem
      end
    end
    
    def pattern_match?(expression)
      matched = true
      for index, keyword in @pattern_list do
        matched = false unless expression[index] == keyword
      end
      matched
    end
    
    def apply(expression)
      expr = transformation
      for key in pattern do
        value = expression.shift
        unless @keywords.include? key
          expr = replace(key, value, expr)
        end
      end
      return expr
    end
    
    def replace(search_atom, new_atom, expr)
      expr.map do |item|
        if item.is_a? Array
          replace(search_atom, new_atom, item)
        else
          (search_atom == item) ? new_atom : item
        end
      end
    end
  end

  class PatternMatcher
    def initialize()
      @macros = {}
    end
    
    def [](expression)
      keyword = expression.first
      if @macros[keyword]
        @macros[keyword].find { |macro| macro.pattern_match?(expression) }
      end
    end
    
    def create_macro!(keywords, pattern, transformation)
      keyword = keywords.first
      @macros[keyword] = [] unless @macros[keyword]
      @macros[keyword] << Macro.new(keywords, pattern, transformation)
    end
  end
end
