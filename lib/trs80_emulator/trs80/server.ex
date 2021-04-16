defmodule Trs80Emulator.Trs80.Server do
  use GenServer

  alias Trs80Emulator.Trs80

  # API
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %Trs80{}, name: :server)
  end

  def fetch_state() do
    GenServer.call(:server, :fetch_state)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:fetch_state, _from, state) do
    {:reply, state, state}
  end
end
