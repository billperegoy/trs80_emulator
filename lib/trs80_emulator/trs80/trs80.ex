defmodule Trs80Emulator.Trs80 do
  alias Trs80Emulator.Z80

  @ram_size 4096

  @type t :: %__MODULE__{
          z80: Z80.t(),
          ram: [byte]
        }

  # Since we have no way to represent unknown state, we will initialize the RAM to all zeroes
  defstruct z80: %Z80{}, ram: List.duplicate(<<0::size(8)>>, @ram_size)

  def reset(%{z80: z80, ram: ram} = trs80) do
    %{trs80 | z80: Z80.reset(z80, ram)}
  end

  def tick(%{z80: z80, ram: ram} = trs80) do
    %{trs80 | z80: Z80.tick(z80, ram)}
  end
end
