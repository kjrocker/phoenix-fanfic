defmodule FfReader.Web.CategoryController do
  use FfReader.Web, :controller
  alias FfReader.Fiction

  def index(conn, _params) do
    categories = Fiction.list_categories()
    render(conn, "index.html", categories: categories)
  end
end
