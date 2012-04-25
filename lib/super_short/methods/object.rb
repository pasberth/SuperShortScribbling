module SuperShort

  module ObjectMethods
    
    include Methods
    alias getter method

    def setter attr
      method(:"#{attr}=")
    end

    def get attr
      send(:"#{attr}")
    end

    def set attr, value
      send(:"#{attr}=", value)
    end
  end
end