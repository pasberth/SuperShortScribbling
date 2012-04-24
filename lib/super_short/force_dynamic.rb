module SuperShort

  module ForceDynamic
    def try_convert_into klass
      __try_convert_into__ klass
    end
    
    def __try_convert_into__ klass
      raise NotImplementedError
    end
    
    def type_inference_by_method method, *args, &blocke
      __type_inference_by_method__ method, *args, &blocke
    end
    
    def __type_inference_by_method__ method, *args, &blocke
      raise NotImplementedError
    end

    def method_missing method, *args, &block
      if (type = type_inference_by_method method, *args, &block) and
         (instance = try_convert_into type) then
        instance.send method, *args, &block
      else
        super
      end
    end
  end

  require 'super_short/force_dynamic/string'
end