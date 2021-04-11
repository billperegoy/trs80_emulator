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

  def execute_instruction(%{registers: registers, ir: ir} = z80) do
    case ir do
      <<0b01::size(2), dest_reg::size(3), src_reg::size(3)>> ->
        ld(z80, src_reg, dest_reg)
        IO.inspect(ir, label: "IR")
        updated_registers = %{registers | a: <<27>>}
        %{z80 | registers: updated_registers}

      _ ->
        z80
    end
  end

  def ld(%{registers: registers} = z80, src_reg, dest_reg) do
    source_value = get_register_value(registers, src_reg)
    updated_registers = set_register_value(registers, dest_reg, source_value)
    %{z80 | registers: updated_registers}
  end

  def get_register_value(registers, src_reg) do
    case src_reg do
      <<0b000::size(3)>> -> registers.b
      <<0b001::size(3)>> -> registers.c
      <<0b010::size(3)>> -> registers.d
      <<0b011::size(3)>> -> registers.e
      <<0b100::size(3)>> -> registers.h
      <<0b101::size(3)>> -> registers.l
      <<0b111::size(3)>> -> registers.a
      _ -> <<0b000>>
    end
  end

  def set_register_value(registers, dest_reg, value) do
    case dest_reg do
      <<0b000::size(3)>> -> %{registers | b: value}
      <<0b001::size(3)>> -> %{registers | c: value}
      <<0b010::size(3)>> -> %{registers | d: value}
      <<0b011::size(3)>> -> %{registers | e: value}
      <<0b100::size(3)>> -> %{registers | h: value}
      <<0b101::size(3)>> -> %{registers | l: value}
      <<0b111::size(3)>> -> %{registers | a: value}
      _ -> registers
    end
  end
end
