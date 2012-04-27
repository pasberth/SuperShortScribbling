require 'spec_helper'

describe "#set!" do
  subject do
    Class.new do
      include SuperShort::ObjectMethods
    end.new
  end

  it { expect { subject.example }.should raise_error NoMethodError }  
  it { expect { subject.example = "lisp" }.should raise_error NoMethodError }  
  it { expect { subject.set! :example, "lisp" }.should_not raise_error }
  it { subject.set! :example, "lisp"; expect { subject.example }.should_not raise_error }
  it { subject.set! :example, "lisp"; subject.example.should == "lisp" }
  it { subject.set!(:example, "lisp").should == "lisp" }
end

describe "#set" do
  subject do
    Class.new do
      include SuperShort::ObjectMethods
      attr_accessor :example
    end.new
  end
  
  its(:example) { should be_nil }
  it { subject.example = "lisp"; subject.example.should == "lisp" }
  it { subject.set :example, "lisp"; subject.example.should == "lisp" }
end

describe "#set" do
  subject do
    Class.new do
      include SuperShort::ObjectMethods
    end.new
  end
  
  it { expect { subject.example }.should raise_error NoMethodError }  
  it { expect { subject.example = "lisp" }.should raise_error NoMethodError }  
  it { expect { subject.set :example, "lisp" }.should raise_error NoMethodError }
end

describe "#set instance variable" do
  subject do
    Class.new do
      include SuperShort::ObjectMethods
    end.new
  end

  it { subject.instance_variable_get(:@example).should be_nil }
  it { subject.set :@example, "lisp"; subject.instance_variable_get(:@example).should == "lisp" }
end

describe "#set class variable" do
  let(:klass) do
    Class.new do
      include SuperShort::ObjectMethods
      @@example = nil
    end
  end
  
  subject { klass.new }

  it { klass.class_variable_get(:@@example).should be_nil }
  it { subject.set :@@example, "lisp"; klass.class_variable_get(:@@example).should == "lisp" }
end

describe "#set_unless" do
  subject do
    Class.new do
      include SuperShort::ObjectMethods
      include SuperShort::Modifiable
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
