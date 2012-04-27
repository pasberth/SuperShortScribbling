module SuperShort

  module ModuleMethods

    include Methods
    include ObjectMethods

    def default_attr_reader attr, default_value=nil
      set! :"default_#{attr}", default_value

      instance_eval(<<-DEF)
        def default_#{attr}
          @default_#{attr}.clone
        rescue TypeError
          @default_#{attr}
        end

        def default_#{attr}= val
          @default_#{attr} = val
        end
      DEF

      module_eval(<<-DEF)
        def #{attr}
          @#{attr} ||= ::#{self.name}.default_#{attr}
        end
      DEF
      default_value
    end
  end
end
