require 'spec_helper'

describe "#send_if" do
  subject do
    Class.new do
      include SuperShort::ObjectMethods
      include SuperShort::Modifiable
      def upcase a
        a.upcase
      end
    end.new
  end
  
  example do
    subject.send_if(:upcase, "lisp").should == "LISP"
  end

  example do
    subject.send_if(:upcase, nil).should be_nil
  end

  example do
    expect { subject.send_if(:upcase, "lisp") }.should_not raise_error
  end

  example do
    expect { subject.send_if(:upcase, nil) }.should_not raise_error
  end

  example do
    expect { subject.send_if(:upcase, true) }.should raise_error NoMethodError
  end

  example do
    expect { subject.send_if(:upcase, false) }.should raise_error NoMethodError
  end
end

describe "#send_if!" do
  subject do
    Class.new do
      include SuperShort::ObjectMethods
      include SuperShort::Modifiable
      def upcase a
        a.upcase
      end
    end.new
  end
  
  example do
    subject.send_if!(:upcase, "lisp").should == "LISP"
  end

  example do
    expect { subject.send_if!(:upcase, "lisp") }.should_not raise_error
  end

  example do
    expect { subject.send_if!(:upcase, nil) }.should raise_error ArgumentError
  end

  example do
    expect { subject.send_if!(:upcase, nil) }.should_not raise_error NoMethodError
  end

  example do
    expect { subject.send_if!(:upcase, true) }.should raise_error NoMethodError
  end

  example do
    expect { subject.send_if!(:upcase, false) }.should raise_error NoMethodError
  end
end
