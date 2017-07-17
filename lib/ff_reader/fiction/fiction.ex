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

  def list_stories do
    Story
    |> preload(:author)
    |> Repo.all
  end

  @doc """
  Gets a single story.

  Raises `Ecto.NoResultsError` if the Story does not exist.

  ## Examples

      iex> get_story!(123)
      %Story{}

      iex> get_story!(456)
      ** (Ecto.NoResultsError)

  """
  def get_story!(id) do
    Story
    |> preload(:author)
    |> preload(chapters: ^from(c in Chapter, order_by: c.number))
    |> Repo.get!(id)
  end

  @doc """
  Creates a story.

  ## Examples

      iex> create_story(%{field: value})
      {:ok, %Story{}}

      iex> create_story(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_story(attrs \\ %{}) do
    %Story{}
    |> Story.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a story.

  ## Examples

      iex> update_story(story, %{field: new_value})
      {:ok, %Story{}}

      iex> update_story(story, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_story(%Story{} = story, attrs) do
    story
    |> Story.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Story.

  ## Examples

      iex> delete_story(story)
      {:ok, %Story{}}

      iex> delete_story(story)
      {:error, %Ecto.Changeset{}}

  """
  def delete_story(%Story{} = story) do
    Repo.delete(story)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking story changes.

  ## Examples

      iex> change_story(story)
      %Ecto.Changeset{source: %Story{}}

  """
  def change_story(%Story{} = story) do
    Story.changeset(story, %{})
  end

  alias FfReader.Fiction.Chapter

  @doc """
  Returns the list of chapters.

  ## Examples

      iex> list_chapters()
      [%Chapter{}, ...]

  """
  def list_chapters do
    Chapter
    |> preload([:story, story: :author])
    |> Repo.all
  end

  @doc """
  Gets a single chapter.

  Raises `Ecto.NoResultsError` if the Chapter does not exist.

  ## Examples

      iex> get_chapter!(123)
      %Chapter{}

      iex> get_chapter!(456)
      ** (Ecto.NoResultsError)

  """
  def get_chapter!(id) do
    Chapter
    |> preload([:story, story: :author])
    |> Repo.get!(id)
  end

  @doc """
  Creates a chapter.

  ## Examples

      iex> create_chapter(%{field: value})
      {:ok, %Chapter{}}

      iex> create_chapter(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_chapter(attrs \\ %{}) do
    %Chapter{}
    |> Chapter.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a chapter.

  ## Examples

      iex> update_chapter(chapter, %{field: new_value})
      {:ok, %Chapter{}}

      iex> update_chapter(chapter, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_chapter(%Chapter{} = chapter, attrs) do
    chapter
    |> Chapter.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Chapter.

  ## Examples

      iex> delete_chapter(chapter)
      {:ok, %Chapter{}}

      iex> delete_chapter(chapter)
      {:error, %Ecto.Changeset{}}

  """
  def delete_chapter(%Chapter{} = chapter) do
    Repo.delete(chapter)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking chapter changes.

  ## Examples

      iex> change_chapter(chapter)
      %Ecto.Changeset{source: %Chapter{}}

  """
  def change_chapter(%Chapter{} = chapter) do
    Chapter.changeset(chapter, %{})
  end
end
