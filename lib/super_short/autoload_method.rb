require 'give4each'

module SuperShort

  module AutoloadMethod
    
    module ClassMethods

      def autoload_method_paths
        @_autoload_method_paths ||= {}
      end

      def autoload_method_paths= paths
        @_autoload_method_paths = paths
      end

      def autoload_method((method, *methods), path)
        [method, *methods].each &:to_sym.and(:[]=, path).to(autoload_method_paths)
      end
      
      def included mod
        mod.extend ClassMethods
        mod.autoload_method_paths = autoload_method_paths.merge(mod.autoload_method_paths)
      end
    end
    
    extend ClassMethods

    def method_missing method, *args, &block
      path = self.class.autoload_method_paths[method] or return super
      begin
        if require path
          send(method, *args, &block)
        else
          super
        end
      rescue LoadError
        super
      end
    end
  end
  
  require 'super_short/autoload_method/string'
end