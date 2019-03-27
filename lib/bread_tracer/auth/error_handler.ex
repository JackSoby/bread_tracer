defmodule BreadTracer.Auth.ErrorHandler do
  import Plug.Conn
  use Phoenix.Controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)

    conn
    |> put_resp_content_type("text/plain")
    |> redirect(to: "/login")
  end
end
