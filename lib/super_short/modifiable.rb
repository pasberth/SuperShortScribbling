module SuperShort
  module Modifiable
    
    module ClassMethods
      include ModuleMethods
      
      def define_infix_operator name
        self.default_infix_operators += [name.to_s]
      end
      
      def define_post_modifier name
        self.default_post_modifiers += [name.to_s]
      end
      
      def define_modifier name
        self.default_modifiers += [name.to_s]
      end
      
      def define_object_word name
        self.default_object_words += [name.to_s]
      end
      
      def self.extended mod
        mod.default_attr_reader :modifiers, []
        mod.default_attr_reader :post_modifiers, []
        mod.default_attr_reader :infix_operators, []
        mod.default_attr_reader :object_words, []
      end
    end
    
    extend ClassMethods

    def method_missing method, *args, &block
      stat = ParserCombinators::InfixExp.parse(
        :input => method.to_s,
        :modifiers => modifiers,
        :post_modifiers => post_modifiers,
        :infix_operators => infix_operators,
        :object_words => object_words) or super

      if stat.empty?
        super
      elsif stat.length == 1
        super
      end
      
      self.class.class_eval(<<-DEFINE)
        def #{method}(*args, &block)                    # def set_if(*args, &block)
          __eval_stat__(self, #{stat}, *args, &block)   #   __eval__stat__(self, ["set", "if"], *args, &block)
        end                                             # end
      DEFINE
      send method, *args, &block
    end
    
    define_infix_operator 'or'
    define_infix_operator 'and'
    define_post_modifier 'if!'
    define_post_modifier 'if'
    define_post_modifier 'in'
    define_object_word 'all'
    define_modifier 'class'
    define_modifier 'will'

    def __eval_stat__ receiver, stat, *args, &block
      stat = stat.clone

      if infix_operators.include? stat.first
        iop = stat.shift
        send "__infix_operator_#{iop}", receiver, stat, *args, &block
      elsif object_words.include? stat.last
        objw = stat.pop
        send "__object_word_#{objw}", receiver, stat, *args, &block
      elsif post_modifiers.include? stat.last
        pmod = stat.pop
        send "__post_modifier_#{pmod}", receiver, stat, *args, &block
      elsif modifiers.include? stat.first
        mod = stat.shift
        send "__modifier_#{mod}", receiver, stat, *args, &block
      elsif stat.length == 1
        receiver.send stat.shift, *args, &block
      else
        super
      end
    end
    
    def __infix_operator_or receiver, stat, *args, &block
      a, b = *stat
      if (result = __eval_stat__ receiver, a, *args, &block).nil?
        __eval_stat__ receiver, b, *args, &block
      else
        result
      end
    end
    
    def __infix_operator_and
      raise NotImplementedError
    end
    
    def __post_modifier_if receiver, stat, *args, &block
      __eval_stat__ receiver, stat, *args, &block unless args.any? &:nil?
    end
    
    def __post_modifier_if! receiver, stat, *args, &block
      raise ArgumentError, "argument must be not nil. (pos #{args.index(nil) + 1} in #{args}." if args.any? &:nil?
      __eval_stat__ receiver, stat, *args, &block
    end
    
    def __post_modifier_in _, stat, receiver, *args, &block
      __eval_stat__ receiver, stat, *args, &block
    end

    def __object_word_all receiver, stat, *args, &block
      args.shift.each { |*a| __eval_stat__ receiver, stat, *a.flatten(1) }
    end
    
    def __modifier_will receiver, stat, *args, &block
      lambda { |*a, &b| __eval_stat__ receiver, stat, *a, &b }
    end
    
    def __modifier_class receiver, stat, *args, &block
      if [Module, Class].include? receiver.class
        __eval_stat__ receiver, stat, *args, &block
      else
        __eval_stat__ receiver.class, stat, *args, &block
      end
    end
    
    def __modifier_try receiver, stat, *args, &block
      begin
        __eval_stat__ receiver, stat, *args, &block
      rescue NoMethodError; end
    end
  end
end