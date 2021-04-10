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
end
