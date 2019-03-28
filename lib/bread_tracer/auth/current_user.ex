defmodule BreadTracer.Auth.CurrentUser do
  import Plug.Conn
  alias BreadTracer.Auth.Guardian, as: BreadTracerGaurdian
  require IEx

  def load_current_user(conn, _) do
    conn
    |> assign(:current_user, BreadTracerGaurdian.Plug.current_resource(conn))
  end
end
