defmodule FfReader.Web.ChapterController do
  use FfReader.Web, :controller

  alias FfReader.Fiction

  # plug :authorize_resource, model: Fiction.Story, id_name: "story_change_id", only: [:new, :create]
  # plug :authorize_resource, model: Fiction.Chapter, only: [:edit, :update]

  def edit(conn, %{"id" => id}) do
    chapter = Fiction.get_chapter!(id)
    changeset = Fiction.change_chapter(chapter)
    render(conn, "edit.html", story: chapter.story, chapter: chapter, changeset: changeset)
  end

  def new(conn, %{"story_change_id" => story_id}) do
    story = Fiction.get_story!(story_id)
    changeset = Fiction.change_chapter(%Fiction.Chapter{})
    render(conn, "new.html", story: story, changeset: changeset)
  end

  def create(conn, %{"story_change_id" => story_id, "chapter" => chapter_params})do
    chapter_params = Map.put(chapter_params, "story_id", story_id)
    story = Fiction.get_story!(story_id)
    case Fiction.create_chapter(chapter_params) do
      {:ok, chapter} ->
        conn
        |> put_flash(:info, "Story created successfully.")
        |> redirect(to: story_path(conn, :show, story))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Error: Errors not created")
        |> render("new.html", changeset: changeset, story: story)
    end
  end

  def update(conn, %{"id" => id, "chapter" => chapter_params}) do
    chapter = Fiction.get_chapter!(id)

    case Fiction.update_chapter(chapter, chapter_params) do
      {:ok, story} ->
        conn
        |> put_flash(:info, "Story updated successfully.")
        |> redirect(to: chapter_path(conn, :show, chapter))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Errors occured. Beep boop.")
        |> render("edit.html", chapter: chapter, changeset: changeset)
    end
  end
end
