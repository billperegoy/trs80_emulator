defmodule Trs80Emulator.Z80 do
  alias Trs80Emulator.Z80.State

  @type t :: %__MODULE__{
          state: State.t()
        }

  defstruct [:state]

  @doc """
  * Clears program counter
  * Clears I and R registers
  * Sets interrupt status to Mode 0
  """
  def reset(%State{} = state) do
    %{state | pc: <<0::size(16)>>, interrupt_reg: <<0::size(08)>>, refresh_reg: <<0::size(8)>>}
  end
end
