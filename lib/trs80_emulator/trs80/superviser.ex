defmodule Trs80Emulator.Trs80.Supervisor do
  use Supervisor

  alias Trs80Emulator.Trs80

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(_) do
    children = [Trs80.Server]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
