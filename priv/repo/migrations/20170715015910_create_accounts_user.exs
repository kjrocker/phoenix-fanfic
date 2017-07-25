defmodule FfReader.Repo.Migrations.CreateFfReader.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :email, :string
      add :username, :string
      add :password_hash, :string

      add :confirmation_token, :string
      add :confirmed_at, :utc_datetime
      add :confirmation_sent_at, :utc_datetime

      add :reset_password_token, :string
      add :reset_password_sent_at, :utc_datetime

      timestamps()
    end

    create unique_index(:accounts_users, [:email])
    create unique_index(:accounts_users, [:username])
  end
end
