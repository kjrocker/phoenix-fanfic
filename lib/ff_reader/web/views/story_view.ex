defmodule FfReader.Web.StoryView do
  use FfReader.Web, :view

  def story_owner(conn, user) do
    current_user(conn).id == user.id
  end

  def current_chapter(chapter_1, chapter_2) do
    chapter_1.number == chapter_2.number
  end

  def next_chapter_url(story, chapter) do
    "/stories/#{story.id}/#{min(story.chapter_count, chapter.number + 1)}"
  end

  def prev_chapter_url(story, chapter) do
    "/stories/#{story.id}/#{max(1, chapter.number - 1)}"
  end
end
