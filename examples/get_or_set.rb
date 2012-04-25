$:.unshift File.dirname(__FILE__) + '/../lib'
require 'sss'

@example = nil
@example ||= "default"
p @example # => "default"

# But if it is boolean type, I'll can't get expecting result by '||='.
@flag = false
@flag ||= true
p @flag # => expecting false but was true.

@flag = false
@flag.nil? and @flag = true
p @flag # => false

@flag = nil
get_or_set :@flag, false
p @flag # => false
get_or_set :@flag, true
p @flag # => false
