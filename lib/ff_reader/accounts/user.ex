defmodule FfReader.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias FfReader.Accounts.User


  schema "accounts_users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password_hash])
    |> validate_required([:email, :password_hash])
  end
end
