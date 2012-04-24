$:.unshift File.dirname(__FILE__) + '/../lib'
require 'sss'

p __dir__ # == File.dirname(__FILE__)
p __lib__
p __bin__