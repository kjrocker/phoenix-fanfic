defmodule FfReader.Fiction.Story do
  use Ecto.Schema
  import Ecto.Changeset
  alias FfReader.Fiction.Story


  schema "fiction_stories" do
    field :summary, :string
    field :title, :string
    belongs_to :author, FfReader.Accounts.User
    has_many :chapters, FfReader.Fiction.Chapter

    timestamps()
  end

  @doc false
  def changeset(%Story{} = story, attrs) do
    story
    |> cast(attrs, [:title, :summary, :author_id])
    |> cast_assoc(:chapters)
    |> validate_required([:title, :summary, :author_id])
    |> assoc_constraint(:author)
  end
end
