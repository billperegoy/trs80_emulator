defmodule Trs80EmulatorWeb.LoginController do
  use Trs80EmulatorWeb, :controller

  def login(conn, _params) do
    render(conn, "login.json", %{pid: 123})
  end
end
