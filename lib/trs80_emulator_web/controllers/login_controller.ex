defmodule Trs80EmulatorWeb.LoginController do
  use Trs80EmulatorWeb, :controller

  def login(conn, _params) do
    server_name = Ecto.UUID.generate()

    render(conn, "login.json", %{server_name: server_name})
  end
end
