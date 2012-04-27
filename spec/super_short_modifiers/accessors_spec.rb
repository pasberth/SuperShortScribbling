describe "OR operator." do
  subject do
    Class.new do
      include SuperShort::ObjectMethods
      include SuperShort::Modifiable
      attr_accessor :example
    end.new
  end
  
  its(:example) { should be_nil }
  it { subject.example = "lisp"; subject.get_or_set :example, "LISP"; subject.example.should == "lisp" }
  it { subject.get_or_set :example, "lisp"; subject.example.should == "lisp" }
  it { subject.example = true; subject.get_or_set :example, "lisp"; subject.example.should == true }
  it { subject.example = false; subject.get_or_set :example, "lisp"; subject.example.should == false }
end