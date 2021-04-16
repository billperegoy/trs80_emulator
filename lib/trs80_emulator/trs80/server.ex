defmodule Trs80Emulator.Trs80.Server do
  use GenServer

  alias Trs80Emulator.Trs80

  # API
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %Trs80{}, name: :server)
  end

  def fetch_state do
    GenServer.call(:server, :fetch_state)
  end

  def reset do
    GenServer.call(:server, :reset)
  end

  def tick do
    GenServer.call(:server, :tick)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:fetch_state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:reset, _from, %{z80: z80} = state) do
    new_z80 = %{z80 | pc: 0}
    new_state = %{state | z80: new_z80}

    {:reply, new_state, new_state}
  end

  def handle_call(:tick, _from, %{z80: z80} = state) do
    new_z80 =
      case z80.pc do
        nil -> z80
        pc -> %{z80 | pc: pc + 1}
      end

    new_state = %{state | z80: new_z80}

    {:reply, new_state, new_state}
  end
end
