$:.unshift File.dirname(__FILE__) + '/../lib'
require 'sss'

puts "SuperShort::AutoloadMethod".underscore # => super_short/autoload_method