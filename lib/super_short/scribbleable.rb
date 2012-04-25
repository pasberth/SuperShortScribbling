module SuperShort
  module Scribbleable
    include SuperShort::ObjectMethods
    include SuperShort::Modifiable
  end
  
  ::Scribbleable = Scribbleable
end
