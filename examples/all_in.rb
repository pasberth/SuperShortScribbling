$:.unshift File.dirname(__FILE__) + '/../lib'
require 'sss'

a = []
unshift_all_in a, %w[a b c]
p a # => ["c", "b", "a"]