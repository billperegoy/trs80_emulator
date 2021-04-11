defmodule Trs80Emulator.Z80 do
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

  @doc """
  * Clears program counter
  * Clears I and R registers
  * Sets interrupt status to Mode 0
  """
  def reset(z80) do
    %{z80 | pc: <<0::size(16)>>, interrupt_reg: <<0::size(08)>>, refresh_reg: <<0::size(8)>>}
  end

  def tick(%{pc: <<high, low>>} = z80) do
    new_low = low + 1

    new_high =
      case low do
        0xFF -> high + 1
        _ -> high
      end

    %{z80 | pc: <<new_high, new_low>>}
  end
end
