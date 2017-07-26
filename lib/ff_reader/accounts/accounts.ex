defmodule FfReader.Accounts do
  import Ecto.Query, warn: false
  alias FfReader.Repo
  alias FfReader.Accounts.User

  def confirmed?(user) do
    !!user.confirmed_at
  end

  def confirm(user) do
    user
    |> User.changeset(%{confirmed_at: Ecto.DateTime.utc, confirmation_token: nil})
  end

  def confirm!(user) do
    changeset = User.changeset(user, %{confirmed_at: Ecto.DateTime.utc, confirmation_token: nil})
    if confirmed?(user) do
      changeset = Ecto.Changeset.add_error(changeset, :confirmed_at, "User already confirmed")
      {:error, changeset}
    else
      Repo.update(changeset)
    end
  end

  def request_confirmation(user, token) do
    changes = %{confirmation_token: token, confirmation_sent_at: Ecto.DateTime.utc()}
    update_user(user, changes)
  end

  def find_confirmation(token) do
    User |> where(confirmation_token: ^token) |> Repo.one
  end

  def list_users(params \\ %{}) do
    User
    |> Repo.paginate(params)
  end

  def get_user_profile(id) do
    User
    |> preload(:stories)
    |> Repo.get(id)
  end

  def get_user!(id), do: Repo.get!(User, id)
  def get_user(id), do: Repo.get(User, id)

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
end
