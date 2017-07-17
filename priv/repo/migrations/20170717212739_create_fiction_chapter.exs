defmodule FfReader.Repo.Migrations.CreateFfReader.Fiction.Chapter do
  use Ecto.Migration

  def change do
    create table(:fiction_chapters) do
      add :title, :string
      add :raw, :text
      add :body, :text
      add :number, :integer
      add :story_id, references(:fiction_stories, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:fiction_chapters, [:story_id, :number])
    create index(:fiction_chapters, [:story_id])
  end
end
