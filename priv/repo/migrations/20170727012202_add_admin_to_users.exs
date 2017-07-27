defmodule FfReader.Repo.Migrations.AddAdminToUsers do
  use Ecto.Migration

  def change do
    alter table(:accounts_users) do
      add :admin, :boolean, default: false, null: false 
    end
  end
end
