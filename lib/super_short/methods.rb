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

    def method_missing method, *args, &block
      stat = ParserCombinators::MethodName.parse(method.to_s) or super
      self.class.class_eval(<<-DEFINE)
        def #{stat.join '_'}(*args, &block)       # def set_if(*args, &block)
          __eval_stat__(#{stat}, *args, &block)   #   __eval__stat__(["sef", "if"], *args, &block)
        end                                       # end
      DEFINE
      send stat.join('_'), *args, &block
    end
    
    def __eval_stat__ stat, *args, &block
      stat = stat.clone
      case stat.last
      when 'if', 'if!', 'unless', 'all'
        pmod = stat.pop
        return send "__post_modifier_#{pmod}", stat, *args, &block
      end

      case stat.first
      when 'class', 'try'
        mod = stat.shift
        return send "__modifier_#{pmod}", stat, *args, &block
      end
      
      case stat.length
      when 1
        send stat.shift, *args, &block
      else
        super
      end
    end
    
    def __post_modifier_if stat, *args, &block
      __eval_stat__ stat, *args, &block unless args.any? &:nil?
    end
    
    def __post_modifier_if! stat, *args, &block
      raise ArgumentError, "argument must be not nil. (pos #{args.index(nil) + 1} in #{args}." if args.any? &:nil?
      __eval_stat__ stat, *args, &block
    end
    
    def __post_modifier_all stat, *args, &block
      args.shift.each { |*a| __eval_stat__ stat, *a.flatten(1) }
    end
    
    def __post_modifier_unless stat, attr, *args, &block
      if ( result = get attr ).nil? then
        __eval_stat__ stat, attr, *args, &block
      else
        result
      end
    end
    
    def __modifier_class stat, *args, &block
      if [Module, Class].include? self.class
        __eval_stat__ stat, *args, &block
      else
        self.class.__eval_stat__ stat, *args, &block
      end
    end
    
    def __modifier_try stat, *args, &block
      begin
        __eval_stat__ stat, *args, &block
      rescue NoMethodError; end
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
  end
end