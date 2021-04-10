defmodule Trs80Emulator.Z80.Registers do
  @type t :: %__MODULE__{
          a: byte,
          b: byte,
          c: byte,
          d: byte,
          e: byte,
          f: byte,
          h: byte,
          l: byte,
          acc: byte,
          flags: byte
        }
  defstruct [:a, :b, :c, :d, :e, :f, :h, :l, :acc, :flags]

  def s_flag(%{flags: <<s::size(1), _::size(7)>>}) do
    s
  end

  def z_flag(%{flags: <<_::size(1), z::size(1), _::size(6)>>}) do
    z
  end

  def h_flag(%{flags: <<_::size(3), z::size(1), _::size(4)>>}) do
    z
  end

  def pv_flag(%{flags: <<_::size(5), pv::size(1), _::size(2)>>}) do
    pv
  end

  def n_flag(%{flags: <<_::size(6), n::size(1), _::size(1)>>}) do
    n
  end

  def c_flag(%{flags: <<_::size(7), c::size(1)>>}) do
    c
  end
end
