defmodule Trs80EmulatorWeb.LoginView do
  use Trs80EmulatorWeb, :view

  def render("login.json", %{pid: pid}) do
    %{pid: "#{pid}"}
  end
end
