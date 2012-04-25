require 'super_short'
extend SuperShort::KernelMethods
extend SuperShort::Scribbleable

class String
  include SuperShort::ForceDynamicString
  include SuperShort::AutoloadMethodString
end