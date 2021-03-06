defmodule BreadTracerWeb.SessionController do
  use BreadTracerWeb, :controller
  require IEx
  alias BreadTracer.{Auth, Auth.Schema.User, Auth.Guardian}

  def new(conn, _) do
    changeset = Auth.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)

    if maybe_user do
      redirect(conn, to: "/secret")
    else
      render(conn, "new.html", changeset: changeset, action: Routes.session_path(conn, :login))
    end
  end

  def login(conn, %{"user" => %{"username" => username, "password" => password}}) do
    result = Auth.authenticate_user(username, password)

    result
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/login")
  end

  defp login_reply({:ok, user}, conn) do
    result =
      conn
      |> put_flash(:success, "Welcome back!")
      |> Guardian.Plug.sign_in(user)

    result
    |> redirect(to: "/secret")
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end

  def secret(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "secret.html", current_user: user)
  end
end
