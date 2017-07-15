defmodule FfReader.Accounts do

  import Ecto.Query, warn: false
  import Comonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Plug.Conn

  alias FfReader.Repo

  alias FfReader.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user, :access)
  end

  def login_by_email_and_pass(conn, email, given_pass) do
    user = Repo.get_by(User, email: email)

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end
end
