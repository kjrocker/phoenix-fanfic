defmodule FfReader.Web.StoryChangeController do
  use FfReader.Web, :controller

  alias FfReader.Fiction

  plug :authorize_resource, model: Fiction.Story, except: [:new, :create]
  plug :put_view, FfReader.Web.StoryView

  def new(conn, _params) do
    changeset = Fiction.change_story(%FfReader.Fiction.Story{
      chapters: [ %Fiction.Chapter{} ]
    })
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"story" => story_params}) do
    story_params = Map.put(story_params, "author_id", current_user(conn).id)
    case Fiction.create_story(story_params) do
      {:ok, story} ->
        conn
        |> put_flash(:info, "Story created successfully.")
        |> redirect(to: story_path(conn, :show, story))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Story creation failed")
        |> render("new.html", changeset: changeset)
    end
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
