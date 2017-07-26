defmodule FfReader.Fiction do
  @moduledoc """
  The boundary for the Fiction system.
  """

  import Ecto.Query, warn: false
  alias FfReader.Repo

  alias FfReader.Fiction.{Story, Chapter}

  def get_first_chapter(id) do
    Chapter
    |> where(story_id: ^id)
    |> first(:number)
    |> Repo.one
  end

  def get_n_chapter(id, num) do
    Chapter
    |> where([story_id: ^id, number: ^num])
    |> Repo.one
  end

  def get_story!(id) do
    Story
    |> preload(chapters: ^from(c in Chapter, order_by: c.number))
    |> preload(:author)
    |> Repo.get!(id)
  end

  def list_stories(params \\ %{}) do
    Story
    |> preload(:author)
    |> Repo.paginate(params)
  end

  def list_chapters do
    Chapter
    |> preload([:story, story: :author])
    |> Repo.all
  end

  def get_chapter!(id) do
    Chapter
    |> preload([:story, story: :author])
    |> Repo.get!(id)
  end

  def create_story(attrs \\ %{}) do
    %Story{}
    |> Story.changeset(attrs)
    |> Repo.insert()
  end

  def create_chapter(attrs \\ %{}) do
    FfReader.Fiction.Chapter.Transaction.call(attrs, :create)
  end

  def update_story(%Story{} = story, attrs) do
    story
    |> Story.changeset(attrs)
    |> Repo.update()
  end

  def update_chapter(%Chapter{} = chapter, attrs) do
    chapter
    |> Chapter.changeset(attrs)
    |> Repo.update()
  end

  def delete_story(%Story{} = story) do
    Repo.delete(story)
  end

  def delete_chapter(%Chapter{} = chapter) do
    FfReader.Fiction.Chapter.Transaction.call(chapter, :delete)
  end

  def change_story(%Story{} = story) do
    Story.changeset(story, %{})
  end

  def change_chapter(%Chapter{} = chapter) do
    Chapter.changeset(chapter, %{})
  end
end
