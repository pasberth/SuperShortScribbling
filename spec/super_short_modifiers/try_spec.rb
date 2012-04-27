require 'spec_helper'

describe "#try_to_ary" do

  context "it was not array." do
    subject do
      Class.new do
        include SuperShort::Modifiable
      end.new
    end
  
    example { expect { subject.to_ary }.should raise_error NoMethodError }
    example { expect { subject.try_to_ary }.should_not raise_error }
    example { subject.try_to_ary.should be_nil }
  end
  
  context "it is array." do
    subject do
      Class.new(Array) do
        include SuperShort::Modifiable
      end.new
    end 
  
    example { expect { subject.to_ary }.should_not raise_error NoMethodError }
    example { expect { subject.try_to_ary }.should_not raise_error }
    example { subject.to_ary.should == [] }
    example { subject.try_to_ary.should == [] }
  end
end