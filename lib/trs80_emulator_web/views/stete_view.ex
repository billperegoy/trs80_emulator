defmodule Trs80EmulatorWeb.StateView do
  use Trs80EmulatorWeb, :view

  def render("index.json", _) do
    %{pc: 1277}
  end
end
