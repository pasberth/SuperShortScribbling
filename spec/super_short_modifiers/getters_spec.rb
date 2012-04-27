describe "#get class variable" do
  let(:klass) do
    Class.new do
      include SuperShort::ObjectMethods
      include SuperShort::Modifiable
      extend SuperShort::ObjectMethods
      extend SuperShort::Modifiable
      @klass_var = "lisp"
      def self.klass_var; @klass_var; end
    end
  end
  
  subject { klass.new }

  it { klass.klass_var.should == "lisp" }
  it { expect { subject.get(:klass_var) }.should raise_error NoMethodError }
  it { klass.class_get(:klass_var).should == "lisp" }
  it { subject.class_get(:klass_var).should == "lisp" }
end

