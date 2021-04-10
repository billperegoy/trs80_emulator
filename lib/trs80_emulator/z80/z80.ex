defmodule Trs80Emulator.Z80 do
  alias Trs80Emulator.Z80.State

  @type t :: %__MODULE__{
          state: State.t()
        }

  defstruct state: %State{}

  @doc """
  * Clears program counter
  * Clears I and R registers
  * Sets interrupt status to Mode 0
  """
  def reset(%State{} = state) do
    %{state | pc: <<0::size(16)>>, interrupt_reg: <<0::size(08)>>, refresh_reg: <<0::size(8)>>}
  end

  def tick(%State{pc: <<high, low>>} = state) do
    new_low = low + 1

    new_high =
      case low do
        0xFF -> high + 1
        _ -> high
      end

    %{state | pc: <<new_high, new_low>>}
  end
end
