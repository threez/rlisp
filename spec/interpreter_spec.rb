require File.dirname(__FILE__) + '/spec_helper'

describe Lisp::Interpreter do
  it "should eval a list to false" do
    lisp_eval("()").should == [false]
  end
  
  it "should be able to quote lists" do
    lisp_eval("(quote (1 2 3))").should == [[1, 2, 3]]
  end

  it "should evaluate lambdas" do
    lisp_eval("((lambda (x) (* x x)) 5)").should == [25]
    lisp_eval("((lambda (a b) ((lambda (a b) (+ a b)) a b)) 1 2)").should == [3]
  end
  
  it "should be able to define functions" do
    lisp_eval("(label t (lambda (a b) (+ a b)))(t 10 20)").last.should == 30
  end
  
  it "should be possible to branch with cond" do
    lisp_eval("(cond (< 1 2) (setq a 1) (setq b 2)) (list a b)").should == [
      1, [1.0, :b]
    ]
  end
  
  it "should calculate the fibonnaci sequence (reqursion)" do
    method, *results = lisp_eval(
      "(label fib (lambda (n)
        (cond (< n 2)
          n
          (+ (fib (- n 1)) 
               (fib (- n 2)))))) " \
      "(fib 0) (fib 1) (fib 2) (fib 3) (fib 4) (fib 5) (fib 6) (fib 7)")
    results.should == [0, 1, 1, 2, 3, 5, 8, 13]
  end
  
  it "should be able to program sequentially (with different scopes)" do
    lisp_eval("(setq a 10)
      (prog 
        (let a (* 2 3)) 
        (let b (* 3 4)) 
        (return (+ a b)))
      (list a)").should == [10, 18, [10]]
  end
end