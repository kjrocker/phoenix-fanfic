defmodule FfReader.Fiction.Chapter do
  use Ecto.Schema
  import Ecto.Changeset
  alias FfReader.Fiction.Chapter


  schema "fiction_chapters" do
    field :body, :string
    field :number, :integer
    field :raw, :string
    field :title, :string
    belongs_to :story, FfReader.Fiction.Story

    timestamps()
  end

  @doc false
  def changeset(%Chapter{} = chapter, attrs) do
    chapter
    |> cast(attrs, [:title, :raw, :number, :story_id])
    |> parse_raw_markdown
    |> validate_required([:title, :raw, :body, :number])
    |> assoc_constraint(:story)
    |> unique_constraint(:number, name: :fiction_chapters_story_id_number_index)
  end

  defp parse_raw_markdown(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{raw: raw_text}} ->
        put_change(changeset, :body, parse_text(raw_text))
      _ -> changeset
    end
  end

  # Paranoid about sanitization
  def parse_text(text) do
    text
    |> HtmlSanitizeEx.basic_html
    |> Earmark.as_html!
    |> HtmlSanitizeEx.basic_html
  end
end
