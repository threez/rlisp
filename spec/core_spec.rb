require File.join(File.dirname(__FILE__), 'spec_helper')

describe Lisp::Core do
  it "cons should construct a new list using an atom and a list" do
    lisp_eval("(cons a b)").should == [[:a, :b]]
    lisp_eval("(cons (a b) c)").should == [[[:a, :b], :c]]
    lisp_eval("(cons (cons a b) c)").should == [[[:a, :b], :c]]
  end

  it "car should return the first element of a list" do
    lisp_eval("(car (a b))").should == [:a]
    lisp_eval("(car (a (b1 b2)))").should == [:a]
    lisp_eval("(car ((a1 a2) b))").should == [[:a1, :a2]]
    lisp_eval("(car a)").should == [nil]
    lisp_eval("(car (cons a b))").should == [:a]
  end
  
  it "cdr should return the rest of a list" do
    lisp_eval("(cdr (a b))").should == [:b]
    lisp_eval("(cdr (a (b1 b2)))").should == [:b1, :b2]
    lisp_eval("(cdr ((a1 a2) b))").should == [:b]
    lisp_eval("(cdr a)").should == [nil]
    lisp_eval("(car (cdr (a (b1 b2))))").should == [:b1]
    lisp_eval("(car (cdr (a b)))").should == [nil]
    lisp_eval("(cdr (cons a b))").should == [:b]
  end
  
  it "atom should return if an element is an atom or not" do
    lisp_eval("(atom extralongstringofletters)").should == [true]
    lisp_eval("(atom (a b))").should == [false]
    lisp_eval("(atom (car (u v)))").should == [true]
  end
end