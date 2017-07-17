defmodule FfReader.Web.StoryView do
  use FfReader.Web, :view

  def current_chapter(chapter_1, chapter_2) do
    if (chapter_1.number == chapter_2.number) do
      "selected"
    else
      ""
    end
  end
end
