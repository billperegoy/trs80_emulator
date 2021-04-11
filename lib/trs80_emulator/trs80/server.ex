defmodule Trs80Emulator.Trs80.Server do
  use GenServer

  alias Trs80Emulator.Trs80

  # API
  def start_link() do
    GenServer.start_link(__MODULE__, %Trs80{})
  end

  def fetch_state(pid) do
    GenServer.call(pid, :fetch_state)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:fetch_state, _from, state) do
    {:reply, state, state}
  end

  #  @impl true
  #  def handle_cast({:push, element}, state) do
  #    {:noreply, [element | state]}
  #  end
end
