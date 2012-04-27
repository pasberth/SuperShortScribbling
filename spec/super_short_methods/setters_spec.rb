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
