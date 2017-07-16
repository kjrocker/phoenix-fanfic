defmodule FfReader.Web.Auth.Helpers do
  def current_user(conn) do
    conn.assigns[:current_user]
  end

  def logged_in?(conn) do
    Guardian.Plug.authenticated?(conn)
  end
end
