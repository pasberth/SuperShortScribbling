module SuperShort
  module Modifiable

    def method_missing method, *args, &block
      stat = ParserCombinators::MethodName.parse(method.to_s) or super
      if stat.empty?
        super
      elsif stat.length == 1
        super
      end
      
      self.class.class_eval(<<-DEFINE)
        def #{stat.join '_'}(*args, &block)       # def set_if(*args, &block)
          __eval_stat__(#{stat}, *args, &block)   #   __eval__stat__(["set", "if"], *args, &block)
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
      when 'class', 'try', 'will'
        mod = stat.shift
        return send "__modifier_#{mod}", stat, *args, &block
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
    
    def __modifier_will stat, *args, &block
      lambda { |*a, &b| __eval_stat__ stat, *a, &b }
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
  end
end