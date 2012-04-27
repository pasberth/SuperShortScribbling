describe do
  
  subject do
    Class.new do
      include SuperShort::ObjectMethods
      include SuperShort::Modifiable
      attr_accessor :example
    end.new
  end

  example do
    subject.first_in(['a']).should == 'a'
  end

  example do
    subject.to_s_in(['a']).should == '["a"]'
  end
end