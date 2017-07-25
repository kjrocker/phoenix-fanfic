defmodule FfReader.Fiction.Chapter.Transaction do
  import Ecto.Query, only: [where: 2]
  alias Ecto.Multi
  alias FfReader.{Repo, Fiction}

  def call(chapter, action) do
    case transaction(chapter, action) |> Repo.transaction do
      {:ok, %{chapter: chapter}} -> {:ok, chapter}
      {:error, _, changeset, _} -> {:error, changeset}
      {:error, _, _, changeset} -> {:error, changeset}
    end
  end

  defp transaction(attrs, :create) do
    Multi.new
    |> Multi.run(:chapter, fn _ -> insert(attrs) end)
    |> Multi.run(:update, fn _ -> update(attrs) end)
  end

  defp transaction(chapter, :delete) do
    Multi.new
    |> Multi.run(:chapter, fn _ -> delete(chapter) end)
    |> Multi.run(:update, fn _ -> update(chapter) end)
  end

  defp insert(attrs) do
    %Fiction.Chapter{}
    |> Fiction.Chapter.changeset(attrs)
    |> Repo.insert()
  end

  defp delete(chapter) do
    Repo.delete(chapter)
  end

  defp update(%{"story_id" => story_id}) do
    update(%{story_id: story_id})
  end

  defp update(%{story_id: story_id}) do
    chapter_count = Fiction.Chapter
    |> where(story_id: ^story_id)
    |> Repo.all
    |> Enum.count
    Fiction.update_story(Fiction.get_story!(story_id), %{chapter_count: chapter_count})
  end
end
