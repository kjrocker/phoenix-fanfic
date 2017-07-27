defmodule FfReader.Fiction.Story do
  use Ecto.Schema
  import Ecto.Changeset
  alias FfReader.Fiction.Story
  alias FfReader.{Accounts, Fiction}


  schema "fiction_stories" do
    field :summary, :string
    field :title, :string
    field :chapter_count, :integer
    belongs_to :author, Accounts.User
    
    many_to_many :series, Fiction.Series, join_through: "series_stories"
    has_many :chapters, Fiction.Chapter

    timestamps()
  end

  @doc false
  def changeset(%Story{} = story, attrs) do
    story
    |> cast(attrs, [:title, :summary, :chapter_count, :author_id])
    |> cast_assoc(:chapters)
    |> validate_required([:title, :summary, :author_id])
    |> assoc_constraint(:author)
    |> assoc_constraint(:series)
  end
end
