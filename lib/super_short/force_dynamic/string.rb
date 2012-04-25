require 'super_short/force_dynamic'

module SuperShort
  module ForceDynamicString
    include ForceDynamic
    
    def __try_convert_into__ klass
      if klass == Symbol then to_sym
      elsif klass == Float then to_f
      elsif klass == Integer then to_i
      end
    end

    def __type_inference_by_method__ method, *args, &blocke
      if Symbol.instance_methods.include? method
        Symbol
      elsif Float.instance_methods.include? method
        Float
      elsif Integer.instance_methods.include? method
        Integer
      end
    end
  end
end