defmodule FfReader.Fiction.Story do
  use Ecto.Schema
  import Ecto.Changeset
  alias FfReader.Fiction.Story


  schema "fiction_stories" do
    field :summary, :string
    field :title, :string

    belongs_to :author, FfReader.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Story{} = story, attrs) do
    story
    |> cast(attrs, [:title, :summary, :author_id])
    |> validate_required([:title, :summary, :author_id])
    |> assoc_constraint(:author)
  end
end
