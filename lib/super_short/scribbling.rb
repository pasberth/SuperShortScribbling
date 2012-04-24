require 'super_short'
extend SuperShort::Methods
class String
  include SuperShort::ForceDynamicString
end