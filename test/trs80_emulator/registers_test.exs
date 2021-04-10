defmodule Trs80Emulator.RegistersTest do
  use Trs80Emulator.DataCase

  alias Trs80Emulator.Z80.Registers

  describe "flags" do
    test "get S flag" do
      assert Registers.s_flag(%{flags: <<0b100_00000>>}) == 1
    end

    test "get Z flag" do
      assert Registers.z_flag(%{flags: <<0b0100_0000>>}) == 1
    end

    test "get H flag" do
      assert Registers.h_flag(%{flags: <<0b0001_0000>>}) == 1
    end

    test "get P/V flag" do
      assert Registers.pv_flag(%{flags: <<0b0000_0100>>}) == 1
    end

    test "get N flag" do
      assert Registers.n_flag(%{flags: <<0b0000_0010>>}) == 1
    end

    test "get C flag" do
      assert Registers.c_flag(%{flags: <<0b0000_0001>>}) == 1
    end
  end
end
