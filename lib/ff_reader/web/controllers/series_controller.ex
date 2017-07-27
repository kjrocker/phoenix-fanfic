defmodule FfReader.Web.SeriesController do
  use FfReader.Web, :controller
  alias FfReader.Fiction

  def index(conn, %{"category_id" => category_id}) do
    series = Fiction.list_series_by_category(category_id)
    render(conn, "index.html", series: series)
  end

  def show(conn, %{"id" => id}) do
    {stories, page} = Map.pop(Fiction.list_stories_by_series(id), :entries)
    render(conn, FfReader.Web.StoryView, "index.html", stories: stories, page: page)
  end
end
