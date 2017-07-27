defmodule FfReader.Web.UserWriteController do
  use FfReader.Web, :controller
  alias FfReader.Accounts

  plug :put_view, FfReader.Web.UserView
  plug :authorize_resource, model: Accounts.User

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)
    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully")
        |> render("show.html", user: user)
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(%{assigns: %{current_user: user}} = conn, _params) do
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: "/")
  end
end
