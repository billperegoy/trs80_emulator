# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :trs80_emulator,
  ecto_repos: [Trs80Emulator.Repo]

# Configures the endpoint
config :trs80_emulator, Trs80EmulatorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+jUrnEPIb7+O/2syp+Zf3/riWZZRrQ2+mAZBFGvGI1fFT+q+QsuBycwZ6G4QX0cK",
  render_errors: [view: Trs80EmulatorWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Trs80Emulator.PubSub,
  live_view: [signing_salt: "KT5EzQ40"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
