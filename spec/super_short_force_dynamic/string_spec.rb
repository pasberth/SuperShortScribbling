require 'spec_helper'

class String
  include SuperShort::ForceDynamicString
end

describe "Force Dynamic Convertion about String." do
  
  example do
    "3".times.to_a.should == [0, 1, 2]
  end

  example do
    ("5" / 2).should == 2.5
  end
end