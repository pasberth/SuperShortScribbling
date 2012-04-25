require 'super_short'
extend SuperShort::Methods
extend SuperShort::Modifiable

class String
  include SuperShort::ForceDynamicString
  include SuperShort::AutoloadMethodString
end