describe do

  subject do
    Class.new do
      include SuperShort::Modifiable
    end.new
  end

  example { expect { subject.class_name_in(Array) }.should_not raise_error }
  example { subject.class_name_in(Array).should == 'Array' }
  example { expect { subject.class_name_in([]) }.should_not raise_error }
  example { subject.class_name_in([]).should == 'Array' }
end
