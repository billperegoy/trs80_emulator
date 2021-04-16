defmodule Trs80EmulatorWeb.LoginView do
  use Trs80EmulatorWeb, :view

  def render("login.json", %{server_name: server_name}) do
    %{server_name: "#{server_name}"}
  end
end
