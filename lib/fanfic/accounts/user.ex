defmodule Fanfic.Accounts.User do
  use Ecto.Schema
  use Coherence.Schema
  import Ecto.Changeset
  alias Fanfic.Accounts.User


  schema "users" do
    field :email, :string
    field :username, :string
    coherence_schema()
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username] ++ coherence_fields)
    |> validate_required([:email, :username])
    |> validate_coherence(attrs)
  end
end
