defmodule FfReader.Web.ChapterPreviewController do
  use FfReader.Web, :controller

  def create(conn, %{"text" => raw_text}) do
    safe_text = raw_text
    |> HtmlSanitizeEx.basic_html
    |> Earmark.as_html!
    |> HtmlSanitizeEx.basic_html
    text(conn, safe_text)
  end
end
