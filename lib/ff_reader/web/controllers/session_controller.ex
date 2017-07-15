defmodule FfReader.Web.SessionController do
  use FfReader.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => user, "password" => pass}}) do
    case Accounts.login_by_email_and_pass(conn, user, pass) do
      {:ok, conn} ->
        logged_in_user = Guardian.Plug.current_resource(conn)
        conn
        |> put_flash(:info, "Login Successful!")
        |> redirect(to: user_path(conn, :show, logged_in_user))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Wrong username/password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "Logged out successfully")
    |> redirect(to: "/")
  end
end
