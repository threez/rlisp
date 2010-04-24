require File.join(File.dirname(__FILE__), 'spec_helper')

describe Lisp::Core do
  it "cons should construct a new cons using an atom and a cons" do
    lisp_eval("(cons a b)").should == [[:a, :b]]
    lisp_eval("(cons (cons a b) c)").should == [[[:a, :b], :c]]
    lisp_eval("(cons (cons a b) c)").should == [[[:a, :b], :c]]
  end

  it "car should return the first element of a cons" do
    lisp_eval("(car (cons a b))").should == [:a]
    lisp_eval("(car (cons a (cons b1 b2)))").should == [:a]
    lisp_eval("(car (cons (cons a1 a2) b))").should == [[:a1, :a2]]
    lisp_eval("(car a)").should == [nil]
    lisp_eval("(car (cons a b))").should == [:a]
    lisp_eval("(car (car (cons (cons a b) c)))").should == [:a]
  end
  
  it "cdr should return the rest of a cons" do
    lisp_eval("(cdr (cons a b))").should == [:b]
    lisp_eval("(cdr (cons a (cons b1 b2)))").should == [[:b1, :b2]]
    lisp_eval("(cdr (cons (cons a1 a2) b))").should == [:b]
    lisp_eval("(cdr a)").should == [nil]
    lisp_eval("(car (cdr (cons a (cons b1 b2))))").should == [:b1]
    lisp_eval("(car (cdr (cons a b)))").should == [nil]
    lisp_eval("(cdr (cons a b))").should == [:b]
  end
  
  it "atom should return if an element is an atom or not" do
    lisp_eval("(atom extralongstringofletters)").should == [true]
    lisp_eval("(atom (cons a b))").should == [false]
    lisp_eval("(atom (car (cons u v)))").should == [true]
  end
end
