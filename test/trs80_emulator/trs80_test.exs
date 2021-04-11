defmodule Trs80Emulator.Trs80Test do
  use Trs80Emulator.DataCase

  alias Trs80Emulator.{Trs80, Z80}

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

    test "fetches instruction after reset", %{trs80: trs80} do
      trs80 = %{trs80 | ram: [<<12>>, <<13>>, <<14>>]}

      trs80 = Trs80.reset(trs80)
      assert trs80.z80.ir == <<12>>
    end

    test "fetches nstruction after tick", %{trs80: trs80} do
      trs80 = %{trs80 | ram: [<<12>>, <<13>>, <<14>>]}

      trs80 = Trs80.reset(trs80)

      trs80 = Trs80.tick(trs80)
      assert trs80.z80.ir == <<13>>

      trs80 = Trs80.tick(trs80)
      assert trs80.z80.ir == <<14>>
    end
  end

  describe "executes instructions" do
    test "single sinstruction", %{trs80: trs80} do
      # Load a from b
      # 0b01111000
      registers = %Z80.Registers{b: <<27>>}
      z80 = %Z80{registers: registers}
      trs80 = %{trs80 | z80: z80, ram: [<<0b01111000>>]}

      trs80 = Trs80.reset(trs80)
      assert trs80.z80.registers.a == <<27>>
    end
  end
end
