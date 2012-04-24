$:.unshift File.dirname(__FILE__) + '/../lib'
require 'sss'

puts __dir__ # == Pathname.new(File.dirname(__FILE__))
puts __lib__ # == __dir__ + '../lib'
puts __bin__ # == __dir__ + '../bin'