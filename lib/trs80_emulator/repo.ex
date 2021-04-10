defmodule Trs80Emulator.Repo do
  use Ecto.Repo,
    otp_app: :trs80_emulator,
    adapter: Ecto.Adapters.Postgres
end
