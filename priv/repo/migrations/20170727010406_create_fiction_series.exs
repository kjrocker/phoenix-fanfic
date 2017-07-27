defmodule FfReader.Repo.Migrations.CreateFictionSeries do
  use Ecto.Migration

  def change do
    create table(:fiction_categories) do
      add :name, :string, null: false
      add :slug, :string, null: false

      timestamps()
    end

    create table(:fiction_series) do
      add :title, :string, null: false
      add :slug, :string, null: false

      # Wiping out series during a category reshuffle makes no sense
      add :category_id, references(:fiction_stories, on_delete: :nothing)

      timestamps()
    end

    create table(:series_stories) do
      # Deleting a story obviously purges it, but keep the assocation
      # with a series so stories that share a series don't get split up
      # if the series is for some reason deleted
      add :story_id, references(:fiction_stories, on_delete: :delete_all)
      add :series_id, references(:fiction_series, on_delete: :nothing)
    end

    create index(:series_stories, [:series_id, :story_id])
    create index(:fiction_series, [:category_id])
    create unique_index(:fiction_series, [:slug])
  end
end
