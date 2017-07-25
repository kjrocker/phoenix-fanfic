defmodule FfReader.Repo.Migrations.CreateFfReader.Fiction.Story do
  use Ecto.Migration

  def change do
    create table(:fiction_stories) do
      add :title, :string
      add :summary, :text
      add :chapter_count, :integer, default: 0, null: false

      add :author_id, references(:accounts_users, on_delete: :delete_all)

      timestamps()
    end

    create index(:fiction_stories, [:author_id])
  end
end
