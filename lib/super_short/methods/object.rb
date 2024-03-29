module SuperShort

  module ObjectMethods
    
    include Methods
    alias getter method

    def setter attr
      method(:"#{attr}=")
    end
    
    def get attr, *args
      case attr.to_s
      when /^@@.*$/ then [Class, Module].include?(self.class) ? class_variable_get(attr) : self.class.class_variable_get(attr)
      when /^@.*$/ then instance_variable_get attr
      else send attr
      end
    end

    def set attr, value
      case attr.to_s
      when /^@@.*$/ then [Class, Module].include?(self.class) ? class_variable_set(attr, value) : self.class.class_variable_set(attr, value)
      when /^@.*$/ then instance_variable_set attr, value
      else send :"#{attr}=", value
      end
    end
    
    def set! attr, value
      case attr.to_s
      when /^@@.*$/, /^@.*$/ then set attr, value
      else
        begin
          send :"#{attr}=", value
        rescue NoMethodError
          instance_eval(<<-DEF)

            def #{attr}
              @#{attr}
            end

            def #{attr}= val
              @#{attr} = val
            end
          DEF
          send :"#{attr}=", value
        end
      end
    end
  end
end