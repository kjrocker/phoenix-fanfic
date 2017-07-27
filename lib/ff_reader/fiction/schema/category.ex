defmodule FfReader.Fiction.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias FfReader.Fiction.{Series, Category}

  schema "fiction_categories" do
    field :title, :string

    has_many :series, Series
    has_many :stories, through: [:series, :stories]

    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
