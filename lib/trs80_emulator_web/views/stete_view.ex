defmodule Trs80EmulatorWeb.StateView do
  use Trs80EmulatorWeb, :view

  def render("index.json", _) do
    %{pc: 0}
  end
end
