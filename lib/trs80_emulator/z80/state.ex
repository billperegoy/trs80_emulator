defmodule Trs80Emulator.Z80.State do
  @type t :: %__MODULE__{
          registers: Registers.t(),
          alternate_registers: Registers.t(),
          pc: <<_::16>>,
          sp: <<_::16>>,
          ix: <<_::16>>,
          iy: <<_::16>>,
          interrupt_reg: byte,
          refresh_reg: byte
        }

  defstruct [:registers, :alternate_registers, :pc, :sp, :ix, :iy, :interrupt_reg, :refresh_reg]
end
