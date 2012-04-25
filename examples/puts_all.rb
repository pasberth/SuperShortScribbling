
$:.unshift File.dirname(__FILE__) + '/../lib'
require 'sss'

case ARGV[0]
when 'by_all'
  ARGV.shift
  puts "puts_all #{ARGV};"
  puts_all ARGV
when 'by_will'
  ARGV.shift
  puts "#{ARGV}.each &will_puts;"
  ARGV.each &will_puts
else
  puts "#{ARGV}.each &will_puts;"
  ARGV.each &will_puts
end