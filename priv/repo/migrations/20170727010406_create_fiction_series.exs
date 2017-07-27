defmodule FfReader.Repo.Migrations.CreateFictionSeries do
  use Ecto.Migration

  def change do
    create table(:fiction_categories) do
      add :name, :string, null: false
    end

    create table(:fiction_series) do
      add :title, :string, null: false
      add :slug, :string, null: false

      # Wiping out series during a category reshuffle makes no sense
      add :category_id, references(:fiction_stories, on_delete: :nothing)

      timestamps()
    end

    alter table(:fiction_stories) do
      # Again, wiping out stories during a series shuffle makes no sense
      add :series_id, references(:fiction_series, on_delete: :nothing)
    end

    create index(:fiction_stories, [:series_id])
    create index(:fiction_series, [:category_id])
    create unique_index(:fiction_series, [:slug])
  end
end
