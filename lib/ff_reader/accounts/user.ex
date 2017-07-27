defmodule FfReader.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias FfReader.Accounts.User


  schema "accounts_users" do
    field :email, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string

    field :reset_password_token, :string
    field :reset_password_sent_at, Ecto.DateTime

    field :confirmation_token, :string
    field :confirmed_at, Ecto.DateTime
    field :confirmation_sent_at, Ecto.DateTime

    has_many :stories, FfReader.Fiction.Story, foreign_key: :author_id

    field :admin, :boolean
    
    timestamps()
  end

  @optional_fields [
    :password_hash,
    :password,
    :password_confirmation,
    :reset_password_token,
    :reset_password_sent_at,
    :confirmation_token,
    :confirmed_at,
    :confirmation_sent_at
  ]

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email] ++ @optional_fields)
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/@/)
    |> validate_authentication(attrs)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> delete_change(:password)
    |> delete_change(:password_confirmation)
  end

  # Methods below this point modified from Coherence
  defp validate_authentication(changeset, params) do
     changeset
     |> validate_length(:password, min: 8)
     |> validate_password(params)
  end

  defp validate_password(changeset, params) do
    if is_nil(Map.get(changeset.data, :password_hash)) && is_nil(changeset.changes[:password]) do
       Ecto.Changeset.add_error(changeset, :password, "Password can't be blank")
    else
      changeset
      |> validate_confirmation(:password)
      |> set_password(params)
    end
  end

  defp set_password(changeset, _params) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, encrypt_password(pass))
      _ -> changeset
    end
  end

  defp encrypt_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end
