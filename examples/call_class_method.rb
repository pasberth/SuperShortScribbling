$:.unshift File.dirname(__FILE__) + '/../lib'
require 'sss'

def show_constants obj_or_class
  p (class_constants_in obj_or_class) - Object.constants
end

show_constants self # == show_constants self.class
show_constants [] # == show_constants [].class
show_constants SuperShort

puts class_name_in [] # == [].class.name
puts class_name_in Array # == Array.name