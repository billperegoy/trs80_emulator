defmodule Trs80EmulatorWeb.StateView do
  use Trs80EmulatorWeb, :view

  def render("index.json", _) do
    state = Trs80Emulator.Trs80.Server.fetch_state()
    %{pc: state.z80.pc}
  end
end
