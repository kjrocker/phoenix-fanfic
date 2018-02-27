defmodule FanficWeb.PageController do
  use FanficWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
