require 'super_short/force_dynamic'

module SuperShort
  module ForceDynamicString
    include ForceDynamic
    
    def __try_convert_into__ klass
      if klass == Symbol then to_sym
      elsif klass == Integer then to_i
      elsif klass == Float then to_f
      end
    end

    def __type_inference_by_method__ method, *args, &blocke
      if Symbol.instance_methods.include? method
        Symbol
      elsif Integer.instance_methods.include? method
        Integer
      elsif Float.instance_methods.include? method
        Float
      end
    end
  end
end