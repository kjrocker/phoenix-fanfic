defmodule FfReader.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias FfReader.Accounts.User


  schema "accounts_users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :stories, FfReader.Fiction.Story, foreign_key: :author_id

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> hash_password
    |> delete_change(:password)
    |> unique_constraint(:email)
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ -> changeset
    end
  end
end
