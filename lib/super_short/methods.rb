module SuperShort
  module Methods
    
    def send_if method, *args, &block
      send(method, *args, &block) unless args.any? &:nil?
    end
    
    def send_if! method, *args, &block
      raise ArgumentError, "argument must be not nil. (pos #{args.index(nil) + 1} in #{args}." if args.any? &:nil?
      send(method, *args, &block)
    end
    
    def set_unless attr, *args, &block
      if ( result = get attr ).nil? then
        set attr, *args, &block
      else
        result
      end
    end
    
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
    
    def set_all attrs
      attrs.each { |attr, value| set attr, value }
    end
  end
end