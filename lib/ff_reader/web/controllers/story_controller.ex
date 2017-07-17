defmodule FfReader.Web.StoryController do
  use FfReader.Web, :controller

  alias FfReader.Fiction

  def index(conn, _params) do
    stories = Fiction.list_stories()
    render(conn, "index.html", stories: stories)
  end

  def new(conn, _params) do
    changeset = Fiction.change_story(%FfReader.Fiction.Story{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"story" => story_params}) do
    case Fiction.create_story(story_params) do
      {:ok, story} ->
        conn
        |> put_flash(:info, "Story created successfully.")
        |> redirect(to: story_path(conn, :show, story))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    story = Fiction.get_story!(id)
    render(conn, "show.html", story: story)
  end

  def edit(conn, %{"id" => id}) do
    story = Fiction.get_story!(id)
    changeset = Fiction.change_story(story)
    render(conn, "edit.html", story: story, changeset: changeset)
  end

  def update(conn, %{"id" => id, "story" => story_params}) do
    story = Fiction.get_story!(id)

    case Fiction.update_story(story, story_params) do
      {:ok, story} ->
        conn
        |> put_flash(:info, "Story updated successfully.")
        |> redirect(to: story_path(conn, :show, story))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", story: story, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    story = Fiction.get_story!(id)
    {:ok, _story} = Fiction.delete_story(story)

    conn
    |> put_flash(:info, "Story deleted successfully.")
    |> redirect(to: story_path(conn, :index))
  end
end
