require 'spec_helper'

describe "#get" do
  subject do
    Class.new do
      include SuperShort::ObjectMethods
      attr_accessor :example
    end.new
  end
  
  its(:example) { should be_nil }
  it { subject.example = "lisp"; subject.get(:example).should == "lisp" }
  it { subject.get(:example).should be_nil }
end

describe "#get instance variable" do
  subject do
    Class.new do
      include SuperShort::ObjectMethods
    end.new
  end

  it { subject.instance_variable_get(:@example).should be_nil }
  it { subject.get(:@example).should be_nil }
  it { subject.instance_variable_set(:@example, "lisp"); subject.get(:@example).should == "lisp" }
end

describe "#get class variable" do
  let(:klass) do
    Class.new do
      include SuperShort::ObjectMethods
      @@example = nil
    end
  end
  
  subject { klass.new }

  it { klass.class_variable_get(:@@example).should be_nil }
  it { subject.get(:@@example).should be_nil }
  it { klass.class_variable_set(:@@example, "lisp"); subject.get(:@@example).should == "lisp" }
end