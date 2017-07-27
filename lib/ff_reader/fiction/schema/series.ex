defmodule FfReader.Fiction.Series do
  use Ecto.Schema
  import Ecto.Changeset
  alias FfReader.Fiction.{Story, Category, Series}


  schema "fiction_series" do
    field :title, :string
    field :slug, :string

    many_to_many :stories, Story, join_through: "series_stories"
    belongs_to :category, Category

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
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{title: title}} ->
        put_change(changeset, :slug, safe_title(title))
      _ -> changeset
    end
  end

  defp safe_title(title) do
    title
    |> String.trim
    |> String.downcase
    |> String.replace(~r/(- )+/, "_")
    |> URI.encode
  end
end
