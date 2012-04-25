#!/usr/bin/env ruby

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

# (main(ARGV[0]) if ARGV[0]) or puts ..
main_if ARGV[0] or puts "Usage: ruby examples/scribble.rb <N>"