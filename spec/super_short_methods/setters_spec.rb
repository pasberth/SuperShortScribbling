require 'spec_helper'

describe "#set" do
  subject do
    Class.new do
      include SuperShort::Methods
      attr_accessor :example
    end.new
  end
  
  its(:example) { should be_nil }
  it { subject.example = "lisp"; subject.example.should == "lisp" }
  it { subject.set :example, "lisp"; subject.example.should == "lisp" }
end

describe "#set_all" do
  subject do
    Class.new do
      include SuperShort::Methods
      attr_accessor :example1
      attr_accessor :example2
    end.new
  end
  
  its(:example1) { should be_nil }
  its(:example2) { should be_nil }
  it do
    subject.set_all({ :example1 => "value1", :example2 => "value2" })
    subject.example1.should == "value1"
    subject.example2.should == "value2"
  end
end

describe "#set_unless" do
  subject do
    Class.new do
      include SuperShort::Methods
      attr_accessor :example
    end.new
  end
  
  its(:example) { should be_nil }
  example do
    subject.set_unless(:example, "lisp").should == "lisp"
    subject.example.should == "lisp"
  end
  
  example do
    subject.example = "LISP"
    subject.set_unless(:example, "lisp").should == "LISP"
    subject.example.should == "LISP"
  end
  
  example do
    subject.example = true
    subject.set_unless(:example, "lisp").should == true
    subject.example.should == true
  end
  
  example do
    subject.example = false
    subject.set_unless(:example, "lisp").should == false
    subject.example.should == false
  end
  
  example do
    subject.example = nil
    subject.set_unless(:example, "lisp").should == "lisp"
    subject.example.should == "lisp"
  end
end
