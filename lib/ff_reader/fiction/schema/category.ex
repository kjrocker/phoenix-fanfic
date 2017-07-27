defmodule FfReader.Fiction.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias FfReader.Fiction.{Series, Category}

  schema "fiction_categories" do
    field :name, :string
    field :slug, :string
    
    has_many :series, Series
    has_many :stories, through: [:series, :stories]

    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:name])
    |> process_name
    |> validate_required([:name, :slug])
  end

  defp process_name(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{name: name}} ->
        put_change(changeset, :slug, process(name))
      _ -> changeset
    end
  end

  defp process(name) do
    name
    |> String.trim
    |> String.downcase
    |> String.split("/")
    |> Enum.at(0)
  end
end
