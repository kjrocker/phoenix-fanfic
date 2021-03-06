defmodule FfReader.Web.StoryController do
  use FfReader.Web, :controller

  alias FfReader.Fiction

  def index(conn, params) do
    {stories, page} = Map.pop(Fiction.list_stories(params), :entries)
    render(conn, "index.html", stories: stories, page: page)
  end

  # Show the specific chapter, otherwise redirect to first chapter
  def show(conn, %{"id" => id, "num" => num}) do
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
  def show(conn, %{"id" => id}) do
    story = Fiction.get_story!(id)
    chapter = Fiction.get_first_chapter(id)
    render(conn, "show.html", story: story, chapter: chapter)
  end
end
