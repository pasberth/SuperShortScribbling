#!/usr/bin/env ruby

# $ ruby examples/scribble.rb <N>
# for example, $ ruby examples/scribble.rb 5

$:.unshift File.dirname(__FILE__) + '/../lib'
require 'sss'

def main n
  puts <<-INFO
================
inspect ; #{n.inspect}
class   : #{n.class}
================
INFO
n.times { |i| puts i } # n.to_i.times { |i| puts i }
end

# ARGV[0] and main(ARGV[0])
send_if! :main, ARGV[0]