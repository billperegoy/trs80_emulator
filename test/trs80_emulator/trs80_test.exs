defmodule Trs80Emulator.Trs80Test do
  use Trs80Emulator.DataCase

  alias Trs80Emulator.Trs80

  setup do
    {:ok, %{trs80: %Trs80{}}}
  end

  describe "initialization" do
    test "has correct memory size", %{trs80: %{ram: ram}} do
      assert Enum.count(ram) == 4096
    end

    test "ram is all initialized to zero", %{trs80: %{ram: ram}} do
      assert Enum.all?(ram, &(&1 == <<0>>))
    end
  end

  describe "basic clocking" do
    test "can be reset and clocked", %{trs80: trs80} do
      trs80 = Trs80.reset(trs80)
      assert trs80.z80.pc == <<0, 0>>

      trs80 = Trs80.tick(trs80)
      assert trs80.z80.pc == <<0, 1>>

      trs80 = Trs80.tick(trs80)
      assert trs80.z80.pc == <<0, 2>>
    end

    test "fetches instructions", %{trs80: trs80} do
      _trs80 = %{trs80 | ram: [<<12>>, <<13>>, <<14>>]}
      assert 1 == 0
    end
  end
end
