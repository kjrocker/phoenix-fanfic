defmodule FfReader.Fiction.Series do
  use Ecto.Schema
  import Ecto.Changeset
  alias FfReader.Fiction.{Story, Category, Series}


  schema "fiction_series" do
    field :title, :string
    field :slug, :string

    has_many :stories, Fiction.Story
    belongs_to :category, Fiction.Category

    timestamps()
  end

  @doc false
  def changeset(%Series{} = story, attrs) do
    story
    |> cast(attrs, [:title])
    |> create_slug
    |> validate_required([:title, :slug])
    |> unique_constraint(:slug)
    |> assoc_constraint(:category)
  end

  defp create_slug(changeset) do
    changeset
  end
end
