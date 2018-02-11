require_relative 'constants'
require_relative 'vm'
require 'byebug'

def print_mem(mem)
  puts mem.map{ |b| "0x%02X" % b }.join(", ")
end

input = [ LOAD, RA, IN1,
          LOAD, RB, IN2,
          ADD,  RA, RB,
          STORE, RA, OUT,
          HALT, 0x00,
          0x00, 0x00,
          0x10, 0x00,
          0x01, 0x00, ]

expected = [ LOAD, RA, IN1,
             LOAD, RB, IN2,
             ADD,  RA, RB,
             STORE, RA, OUT,
             HALT, 0x00,
             0x11, 0x00,
             0x10, 0x00,
             0x01, 0x00, ]

output = VM.new(input).run

print "in: "
print_mem(input)
print "ex: "
print_mem(expected)
print "ac: "
print_mem(output)

puts output == expected
