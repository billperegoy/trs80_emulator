defmodule Trs80Emulator.Z80.InstructionDecode do
  def ld(%{registers: registers} = z80, src_reg, dest_reg) do
    source_value = get_register_value(registers, src_reg)
    updated_registers = set_register_value(registers, dest_reg, source_value)

    %{z80 | registers: updated_registers}
  end

  def get_register_value(registers, src_reg) do
    case src_reg do
      0b000 -> registers.b
      0b001 -> registers.c
      0b010 -> registers.d
      0b011 -> registers.e
      0b100 -> registers.h
      0b101 -> registers.l
      0b111 -> registers.a
      _ -> nil
    end
  end

  def set_register_value(registers, dest_reg, value) do
    case dest_reg do
      0b000 -> %{registers | b: value}
      0b001 -> %{registers | c: value}
      0b010 -> %{registers | d: value}
      0b011 -> %{registers | e: value}
      0b100 -> %{registers | h: value}
      0b101 -> %{registers | l: value}
      0b111 -> %{registers | a: value}
      _ -> registers
    end
  end
end
