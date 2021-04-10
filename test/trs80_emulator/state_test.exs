defmodule Trs80Emulator.StateTest do
  use Trs80Emulator.DataCase

  alias Trs80Emulator.{Z80, Z80.State}

  describe "reset" do
    setup do
      {:ok, %{state: %State{}}}
    end

    test "clears program counter", %{state: state} do
      new_state = Z80.reset(state)
      assert new_state.pc == <<0::size(16)>>
    end

    test "clears interrupt vector", %{state: state} do
      new_state = Z80.reset(state)
      assert new_state.interrupt_reg == <<0::size(8)>>
    end

    test "clears memory refresh register", %{state: state} do
      new_state = Z80.reset(state)
      assert new_state.refresh_reg == <<0::size(8)>>
    end
  end

  describe "tick" do
    test "increments PC" do
      state = %State{pc: <<0::size(16)>>}

      new_state = Z80.tick(state)
      assert(new_state.pc == <<1::size(16)>>)
    end

    test "wraps on 8 bit PC boundary" do
      state = %State{pc: <<0x00FF::size(16)>>}

      new_state = Z80.tick(state)
      assert(new_state.pc == <<0x0100::size(16)>>)
    end

    test "PC wraps at 16 bit boundary" do
      state = %State{pc: <<0xFFFF::size(16)>>}

      new_state = Z80.tick(state)
      assert(new_state.pc == <<0::size(16)>>)
    end
  end
end
