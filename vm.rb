require_relative 'constants'
class VM

  def initialize(mem)
    @mem = mem
    @pc = 0
    @registers = {
      RA => 0x0000,
      RB => 0x0000,
    }
  end

  def run
    loop do
      case @mem[@pc]
      when LOAD
        input_addr = @mem[@pc + 2]
        reg_key = @mem[@pc + 1]
        @registers[reg_key] = read(input_addr)
      when ADD
        stor_reg = @mem[@pc + 1]
        read_reg = @mem[@pc + 2]
        @registers[stor_reg] += @registers[read_reg]
      when STORE
        read_reg = @mem[@pc + 1]
        write_addr = @mem[@pc + 2]
        write(write_addr, @registers[read_reg])
      when HALT
        @pc = 0
        return @mem
      end
      @pc += 3
    end
  end

  private

  def read(addr)
    low = @mem[addr]
    high = @mem[addr + 1]
    (high * 256) + low
  end

  def write(addr, value)
    low = value % 256
    high = (value - low) / 256
    @mem[addr] = low
    @mem[addr + 1] = high
  end

end


