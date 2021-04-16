defmodule Trs80Emulator.Trs80.Supervisor do
  use Supervisor

  alias Trs80Emulator.Trs80

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok, name: :trs80_pool)
  end

  def start_server(name) do
    Supervisor.start_child(:trs80_pool, [name])
  end

  @impl true
  def init(:ok) do
    children = [Trs80.Server]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
