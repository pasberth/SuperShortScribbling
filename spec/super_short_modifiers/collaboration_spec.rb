
describe "collaborate OR and IF." do
  subject do
    Class.new do
      include SuperShort::ObjectMethods
      include SuperShort::Modifiable
      attr_accessor :example
    end.new
  end
  
  it { subject.get_or_set_if :example, "lisp"; subject.example.should == "lisp" }
  it { subject.get_or_set_if :example, "lisp"; subject.get_or_set_if :example, "LISP"; subject.example.should == "lisp" }
  it { expect { subject.get_or_set_if nil, nil }.should_not raise_error }
  it { subject.get_or_set_if(nil, nil).should be_nil }
  it { expect { subject.get_or_set nil, nil }.should raise_error }
end

describe "collaborate OR and IN." do
  subject do
    Class.new do
      include SuperShort::Modifiable
    end.new
  end
  
  let(:target) do
    Class.new do
      include SuperShort::ObjectMethods
      attr_accessor :example
    end.new
  end
  
  it { subject.get_or_set_in(target, :example, "lisp"); target.example.should == "lisp" }
  it { subject.get_or_set_in target, :example, "lisp"; subject.get_or_set_in target, :example, "LISP"; target.example.should == "lisp" }
  it { expect { subject.get_or_set_in target, :example, "lisp" }.should_not raise_error }
end
