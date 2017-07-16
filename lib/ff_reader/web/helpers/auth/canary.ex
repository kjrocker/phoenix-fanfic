defmodule FfReader.Web.Auth.Canary do
  use FfReader.Web, :controller

  def handle_unauthorized(conn) do
    conn
    |> put_flash(:error, "You can't access that page!")
    |> redirect(to: "/")
    |> halt
  end

  def handle_not_found(conn) do
    conn
    |> put_flash(:error, "The page you're looking for can't be found!")
    |> put_status(:not_found)
    |> redirect(to: "/")
    |> halt
  end
end
