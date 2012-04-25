module SuperShort

  module Methods
    begin
      require 'binding_of_caller'
      require 'pathname'
    
      def __root__
        Pathname.new '..'
      end

      def __dir__
        Pathname.new File.dirname binding.of_caller(2).eval('__FILE__')
      end
      
      def __lib__
        __dir__ + __root__ + 'lib'
      end
      
      def __bin__
        __dir__ + __root__ + 'bin'
      end
    rescue LoadError; end
  end
end