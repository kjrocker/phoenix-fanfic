defmodule FfReader.Web.UserController do
  use FfReader.Web, :controller
  alias FfReader.Accounts
  import FfReader.Web.Auth.Login

  def index(conn, _params) do
    users = Accounts.list_users
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%Accounts.User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> send_confirmation(user)
        |> login(user)
        |> put_flash(:info, "User created successfully")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  defp send_confirmation(conn, user) do
    token = Phoenix.Token.sign(FfReader.Web.Endpoint, "user", user.id)
    url = confirmation_url(conn, :edit, token)
    {:ok, user} = Accounts.request_confirmation(user, token)
    FfReader.Email.confirmation_email(user, url) |> FfReader.Mailer.deliver_later
    conn
  end
end
