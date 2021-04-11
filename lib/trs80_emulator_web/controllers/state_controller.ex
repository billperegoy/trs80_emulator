defmodule Trs80EmulatorWeb.StateController do
  use Trs80EmulatorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json")
  end
end
