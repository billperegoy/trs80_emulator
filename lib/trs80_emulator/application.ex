defmodule Trs80Emulator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Trs80Emulator.Repo,
      # Start the Telemetry supervisor
      Trs80EmulatorWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Trs80Emulator.PubSub},
      # Start the Endpoint (http/https)
      Trs80EmulatorWeb.Endpoint,
      # Start a worker by calling: Trs80Emulator.Worker.start_link(arg)
      # {Trs80Emulator.Worker, arg}
      {DynamicSupervisor, strategy: :one_for_one, name: Trs80Emulator.Trs80.Supervisor},
      Trs80Emulator.Trs80.Registry
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Trs80Emulator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Trs80EmulatorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
