describe "#set_all" do
  subject do
    Class.new do
      include SuperShort::ObjectMethods
      include SuperShort::Modifiable
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

describe "#set_if" do
  subject do
    Class.new do
      include SuperShort::ObjectMethods
      include SuperShort::Modifiable
      attr_accessor :example
    end.new
  end
  
  its(:example) { should be_nil }
  it { subject.example = "lisp"; subject.example.should == "lisp" }
  it { subject.set_if :example, "lisp"; subject.example.should == "lisp" }
  it { subject.set_if :example, "lisp"; subject.set_if :example, nil; subject.example.should == "lisp" }
  it { subject.set_if :example, "lisp"; subject.set_if :example, "LISP"; subject.example.should == "LISP" }
  it { subject.set_if :example, nil; subject.example.should be_nil }
  it { subject.set_if :example, nil; subject.set_if :example, "lisp"; subject.example.should == "lisp" }
  it { subject.set_if :example, true; subject.example.should == true }
  it { subject.set_if :example, false; subject.example.should == false }
  it { subject.set_if :example, "lisp"; subject.set_if :example, true; subject.example.should == true }
  it { subject.set_if :example, "lisp"; subject.set_if :example, false; subject.example.should == false }
end

