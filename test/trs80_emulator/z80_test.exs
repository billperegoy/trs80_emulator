defmodule Trs80Emulator.StateTest do
  use Trs80Emulator.DataCase

  alias Trs80Emulator.Z80
  @ram List.duplicate(<<0>>, 4096)

  describe "reset" do
    setup do
      {:ok, %{z80: %Z80{}}}
    end

    test "clears program counter", %{z80: z80} do
      new_state = Z80.reset(z80, @ram)
      assert new_state.pc == <<0::size(16)>>
    end

    test "clears interrupt vector", %{z80: z80} do
      new_state = Z80.reset(z80, @ram)
      assert new_state.interrupt_reg == <<0::size(8)>>
    end

    test "clears memory refresh register", %{z80: z80} do
      new_state = Z80.reset(z80, @ram)
      assert new_state.refresh_reg == <<0::size(8)>>
    end
  end

  describe "tick" do
    test "increments PC" do
      z80 = %Z80{pc: <<0::size(16)>>}

      new_state = Z80.tick(z80, @ram)
      assert(new_state.pc == <<1::size(16)>>)
    end

    test "wraps on 8 bit PC boundary" do
      z80 = %Z80{pc: <<0x00FF::size(16)>>}

      new_state = Z80.tick(z80, @ram)
      assert(new_state.pc == <<0x0100::size(16)>>)
    end

    test "PC wraps at 16 bit boundary" do
      z80 = %Z80{pc: <<0xFFFF::size(16)>>}

      new_state = Z80.tick(z80, @ram)
      assert(new_state.pc == <<0::size(16)>>)
    end
  end
end
