defmodule Trs80Emulator.Z80 do
  alias Trs80Emulator.Z80.Registers

  @type t :: %__MODULE__{
          registers: Registers.t(),
          alternate_registers: Registers.t(),
          pc: <<_::16>>,
          ir: <<_::8>>,
          sp: <<_::16>>,
          ix: <<_::16>>,
          iy: <<_::16>>,
          interrupt_reg: byte,
          refresh_reg: byte
        }

  defstruct [
    :alternate_registers,
    :pc,
    :ir,
    :sp,
    :ix,
    :iy,
    :interrupt_reg,
    :refresh_reg,
    registers: %Registers{}
  ]

  @doc """
  * Clears program counter
  * Clears I and R registers
  * Sets interrupt status to Mode 0
  """
  def reset(z80, ram) do
    %{
      z80
      | pc: <<0::size(16)>>,
        ir: Enum.at(ram, 0),
        interrupt_reg: <<0::size(08)>>,
        refresh_reg: <<0::size(8)>>
    }
    |> execute_instruction()
  end

  def tick(%{pc: <<high, low>>} = z80, ram) do
    new_low = low + 1

    new_high =
      case low do
        0xFF -> high + 1
        _ -> high
      end

    ram_address = 256 * new_high + new_low

    %{z80 | pc: <<new_high, new_low>>, ir: Enum.at(ram, ram_address)}
    |> execute_instruction()
  end

  def execute_instruction(%{registers: registers} = z80) do
    updated_registers = %{registers | a: <<27>>}
    %{z80 | registers: updated_registers}
  end
end
