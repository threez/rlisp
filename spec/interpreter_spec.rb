require File.join(File.dirname(__FILE__), 'spec_helper')

describe Lisp::Interpreter do
  it "should eval a cons to false" do
    lisp_eval("()").should == [false]
  end
  
  it "should be able to quote conss" do
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
    lisp_eval("(cond (< 1 2) (setq a 1) (setq b 2)) (cons a b)").should == [
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
      (cons a)").should == [10, 18, [10]]
  end
  
  it "should import the macros and caar's and cadr's from the stdlib dir" do
    t1, t2, *rest = lisp_eval("(import common)
    (defun t (a b) (+ a b))
    (t 10 20)")
    rest.should == [30]
  end
  
  it "should work on strings" do
    lisp_eval('(+ "abc" "def")').should == ["abcdef"]
    lisp_eval('(+ "abc" "def" "ghi")').should == ["abcdefghi"]
    lisp_eval('(car "abc")').should == ["a"]
    lisp_eval('(cdr "abc")').should == ["bc"]
    lisp_eval('(setq q "blah")(+ q "blub")').should == ["blah", "blahblub"]
  end
end
