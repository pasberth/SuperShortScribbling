require 'super_short'
extend SuperShort::KernelMethods
extend SuperShort::ObjectMethods
extend SuperShort::Modifiable

class String
  include SuperShort::ForceDynamicString
  include SuperShort::AutoloadMethodString
end