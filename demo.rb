require_relative 'constants'
require_relative 'vm'

def print_mem(mem)
  puts mem.map{ |b| "0x%02X" % b }.join(", ")
end

puts "0x0010 + 0x0001 == 0x0011"
input = [
  LOAD, RA, IN1,
  LOAD, RB, IN2,
  ADD, RA, RB,
  STORE, RA, OUT,
  HALT, 0x00,
  0x00, 0x00, # output
  0x10, 0x00, # input 1
  0x01, 0x00, # input 2
]

expected = [
  LOAD, RA, IN1,
  LOAD, RB, IN2,
  ADD, RA, RB,
  STORE, RA, OUT,
  HALT, 0x00,
  0x11, 0x00, # output
  0x10, 0x00, # input 1
  0x01, 0x00, # input 2
]

output = VM.new(input).run
puts output == expected

puts "0x007B + 0x001C == 0x0097"
input = [
  LOAD, RA, IN1,
  LOAD, RB, IN2,
  ADD, RA, RB,
  STORE, RA, OUT,
  HALT, 0x00,
  0x00, 0x00, # output
  0x7B, 0x00, # input 1
  0x1C, 0x00, # input 2
]

expected = [
  LOAD, RA, IN1,
  LOAD, RB, IN2,
  ADD, RA, RB,
  STORE, RA, OUT,
  HALT, 0x00,
  0x97, 0x00, # output
  0x7B, 0x00, # input 1
  0x1C, 0x00, # input 2
]

output = VM.new(input).run
puts output == expected

puts "0xDADA + 0x0001 == 0xDADB"
input = [
  LOAD, RA, IN1,
  LOAD, RB, IN2,
  ADD, RA, RB,
  STORE, RA, OUT,
  HALT, 0x00,
  0x00, 0x00, # output
  0xDA, 0xDA, # input 1
  0x01, 0x00, # input 2
]

expected = [
  LOAD, RA, IN1,
  LOAD, RB, IN2,
  ADD, RA, RB,
  STORE, RA, OUT,
  HALT, 0x00,
  0xDB, 0xDA, # output
  0xDA, 0xDA, # input 1
  0x01, 0x00, # input 2
]

output = VM.new(input).run
puts output == expected

puts "0xCAFE + 0x0B0E == 0xD60C"
input = [
  LOAD, RA, IN1,
  LOAD, RB, IN2,
  ADD, RA, RB,
  STORE, RA, OUT,
  HALT, 0x00,
  0x00, 0x00, # output
  0xFE, 0xCA, # input 1
  0x0E, 0x0B, # input 2
]

expected = [
  LOAD, RA, IN1,
  LOAD, RB, IN2,
  ADD, RA, RB,
  STORE, RA, OUT,
  HALT, 0x00,
  0x0C, 0xD6, # output
  0xFE, 0xCA, # input 1
  0x0E, 0x0B, # input 2
]

output = VM.new(input).run
puts output == expected
