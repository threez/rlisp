require File.join(File.dirname(__FILE__), 'spec_helper')

describe Lisp::Parser do
  it "should parse a empty list as emtpy array" do
    lisp_parse("()").should == [[]]
  end

  it "should parse a list of lists" do
    lisp_parse("((())(()))").should == [[[[]], [[]]]]
  end
  
  it "should parse multiple lists at root level" do
    lisp_parse("()()").should == [[], []]
  end
  
  it "should parse a list of atoms" do
    lisp_parse("(a b c)").should == [[:a, :b, :c]]
  end
  
  it "should parse a list of atoms in lists" do
    lisp_parse("(a b c (d (e)) f)").should == [[:a, :b, :c, [:d, [:e]], :f]]
  end
  
  it "should parse numbers correctly" do
    lisp_parse("(1 2 3 4)").should == [[1, 2, 3, 4]]
  end
  
  it "should parse signs correctly" do
    lisp_parse("(+ 1 2)").should == [[:"+", 1.0, 2.0]]
  end
  
  it "should parse strings correctly" do
    lisp_parse('(+ "abc" "def" "ghi\" \"jkm")').should == [
      [:"+", "abc", "def", "ghi\" \"jkm"]
    ]
  end
end
