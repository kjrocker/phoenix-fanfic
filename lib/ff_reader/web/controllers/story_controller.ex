defmodule FfReader.Web.StoryController do
  use FfReader.Web, :controller

  alias FfReader.Fiction

  def index(conn, _params) do
    stories = Fiction.list_stories()
    render(conn, "index.html", stories: stories)
  end

  # Show the specific chapter, otherwise redirect to first chapter
  def show(conn, %{"id" => id, "num" => num} = params) do
    story = Fiction.get_story!(id)
    case Fiction.get_n_chapter(id, num) do
      %Fiction.Chapter{} = chapter ->
        render(conn, "show.html", story: story, chapter: chapter)
      nil ->
        conn
        |> put_flash(:error, "Requested chapter not found")
        |> redirect(to: story_path(conn, :show, story))
    end
  end

  # Without a chapter number, use the first one
  def show(conn, %{"id" => id} = params) do
    story = Fiction.get_story!(id)
    chapter = Fiction.get_first_chapter(id)
    render(conn, "show.html", story: story, chapter: chapter)
  end
end
