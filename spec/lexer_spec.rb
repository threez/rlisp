require File.join(File.dirname(__FILE__), 'spec_helper')

describe Lisp::Lexer do
  
  it "should lex a empty list" do
    lisp_lex("()").should == [[:begin], [:end]]
  end
  
  it "should lex a list of lists" do
    lisp_lex("(())").should == [[:begin], [:begin], [:end], [:end]]
  end
  
  it "should lex a list of multiple lists" do
    lisp_lex("((())(()))").should == [
      [:begin], 
        [:begin], [:begin], [:end], [:end],
        [:begin], [:begin], [:end], [:end], 
      [:end]
    ]
  end
  
  it "should ignore comments" do
    lisp_lex(";; foo bar\n()").should == [[:begin], [:end]]
  end
  
  it "should lex a simple list of atoms" do
    lisp_lex("(a b c)").should == [
      [:begin], 
        [:atom, :a], [:atom, :b], [:atom, :c], 
      [:end]
    ]
  end
  
  it "should lex a list of lists and atoms" do
    lisp_lex("(a b c (a b (a b)))").should == [
      [:begin], 
        [:atom, :a], [:atom, :b], [:atom, :c], 
        [:begin], 
          [:atom, :a], [:atom, :b],
          [:begin], 
            [:atom, :a], [:atom, :b],
          [:end], 
        [:end], 
      [:end]
    ]
  end
  
  it "should lex a list of number atoms" do
    lisp_lex("((1 2 3 4) 1 2)").should == [
      [:begin], 
        [:begin], 
          [:number, 1], [:number, 2], [:number, 3], [:number, 4], 
        [:end],
        [:number, 1], [:number, 2], 
      [:end]
    ]
  end
  
  it "should lex signs like atoms" do
    lisp_lex("(+ - *)").should == [
      [:begin], 
        [:atom, :"+"], [:atom, :"-"], [:atom, :"*"], 
      [:end]
    ]
  end
end