defmodule FfReader.Fiction do
  @moduledoc """
  The boundary for the Fiction system.
  """

  import Ecto.Query, warn: false
  alias FfReader.Repo

  alias FfReader.Fiction.Story

  @doc """
  Returns the list of stories.

  ## Examples

      iex> list_stories()
      [%Story{}, ...]

  """
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
end
