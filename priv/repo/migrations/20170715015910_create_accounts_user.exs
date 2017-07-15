defmodule FfReader.Repo.Migrations.CreateFfReader.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :email, :string
      add :password_hash, :string

      timestamps()
    end
  end
end
