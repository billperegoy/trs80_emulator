defmodule Trs80EmulatorWeb.PageController do
  use Trs80EmulatorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
