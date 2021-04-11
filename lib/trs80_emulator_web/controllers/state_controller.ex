defmodule Trs80EmulatorWeb.StateController do
  use Trs80EmulatorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json")
  end

  def create(conn, _params) do
    # FIXME - Create a new genserver istance and return the PID
    render(conn, "create.json")
  end
end
