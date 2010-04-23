require File.dirname(__FILE__) + '/spec_helper'

describe Lisp::Math do
  it "should be able to do simple math (+, -, *, /)" do
    lisp_eval("(+)(-)(*)(/)").should == [0, 0, 0, 0]
    lisp_eval("(+ 1)(+ 1 2)(+ 1 2 3)").should == [1, 3, 6]
    lisp_eval("(- 1)(- 1 2)(- 1 2 3)").should == [1, -1, -4]
    lisp_eval("(* 1)(* 1 2)(* 1 2 3)").should == [1, 2, 6]
    lisp_eval("(/ 1)(/ 1 2)(/ 1 2 3)").should == [1, 0.5, 0.5 / 3.0]
  end
  
  it "should be able to do more math" do
    lisp_eval("(+ (* 2 2) (* 3 3))").should == [13]
    lisp_eval("(% 10 3)(% 30 9 2)").should == [1, 1]
  end
  
  it "should be able to do equations" do
    lisp_eval("(== 1 1)(== 1 1 1)(== 1 1 2)(== 2 1)").should == [
      true, true, false, false
    ]
    lisp_eval("(< 1 2 3)(> 1 2)(< 1 2 0)").should == [true, false, false]
  end
  
  it "should should be able to check equality" do
    lisp_eval("(== a a)").should == [true]
    lisp_eval("(== a b)").should == [false]
    lisp_eval("(== a (a b))").should == [nil]
    lisp_eval("(== (a b) (a b))").should == [nil]
  end
end