defmodule FfReader.FictionTest do
  use FfReader.DataCase

  alias FfReader.Fiction

  describe "stories" do
    alias FfReader.Fiction.Story

    @valid_attrs %{summary: "some summary", title: "some title"}
    @update_attrs %{summary: "some updated summary", title: "some updated title"}
    @invalid_attrs %{summary: nil, title: nil}

    test "list_stories/0 returns all stories" do
      story = insert(:story)
      assert Fiction.list_stories() == [story]
    end

    test "get_story!/1 returns the story with given id" do
      story = insert(:story)
      assert Fiction.get_story!(story.id)
    end

    test "create_story/1 with valid data creates a story" do
      valid_attrs = params_with_assocs(:story, @valid_attrs)
      assert {:ok, %Story{} = story} = Fiction.create_story(valid_attrs)
      assert story.title == "some title"
      assert story.summary == "some summary"
    end

    test "create_story/1 with invalid data returns error changeset" do
      invalid_attrs = params_with_assocs(:story, @invalid_attrs)
      assert {:error, %Ecto.Changeset{}} = Fiction.create_story(invalid_attrs)
    end

    test "update_story/2 with valid data updates the story" do
      story = insert(:story)
      assert {:ok, story} = Fiction.update_story(story, @update_attrs)
      assert %Story{} = story
      assert story.summary == "some updated summary"
      assert story.title == "some updated title"
    end

    test "update_story/2 with invalid data returns error changeset" do
      story = insert(:story)
      invalid_attrs = %{title: nil, summary: nil}
      assert {:error, %Ecto.Changeset{}} = Fiction.update_story(story, invalid_attrs)
      assert Fiction.get_story!(story.id).updated_at == story.updated_at
    end

    test "delete_story/1 deletes the story" do
      story = insert(:story)
      assert {:ok, %Story{}} = Fiction.delete_story(story)
      assert_raise Ecto.NoResultsError, fn -> Fiction.get_story!(story.id) end
    end

    test "change_story/1 returns a story changeset" do
      story = insert(:story)
      assert %Ecto.Changeset{} = Fiction.change_story(story)
    end
  end

  describe "chapters" do
    alias FfReader.Fiction.Chapter

    @valid_attrs %{body: "some body", number: 42, raw: "some raw", title: "some title"}
    @update_attrs %{number: 43, raw: "some updated raw", title: "some updated title"}
    @invalid_attrs %{body: nil, number: nil, raw: nil, title: nil}

    test "list_chapters/0 returns all chapters" do
      chapter = insert(:chapter)
      assert Fiction.list_chapters() == [chapter]
    end

    test "get_chapter!/1 returns the chapter with given id" do
      chapter = insert(:chapter)
      assert Fiction.get_chapter!(chapter.id) == chapter
    end

    test "create_chapter/1 with valid data creates a chapter" do
      valid_attrs = params_for(:chapter, title: "Chapter Title", story: insert(:story))
      assert {:ok, %Chapter{} = chapter} = Fiction.create_chapter(valid_attrs)
      assert chapter.title == "Chapter Title"
    end

    test "create_chapter/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fiction.create_chapter(@invalid_attrs)
    end

    test "update_chapter/2 with valid data updates the chapter" do
      chapter = insert(:chapter)
      assert {:ok, chapter} = Fiction.update_chapter(chapter, @update_attrs)
      assert %Chapter{} = chapter
      assert chapter.body =~ "some updated raw"
      assert chapter.number == 43
      assert chapter.raw == "some updated raw"
      assert chapter.title == "some updated title"
    end

    test "update_chapter/2 with invalid data returns error changeset" do
      chapter = insert(:chapter)
      assert {:error, %Ecto.Changeset{}} = Fiction.update_chapter(chapter, @invalid_attrs)
      assert chapter == Fiction.get_chapter!(chapter.id)
    end

    test "delete_chapter/1 deletes the chapter" do
      chapter = insert(:chapter)
      assert {:ok, %Chapter{}} = Fiction.delete_chapter(chapter)
      assert_raise Ecto.NoResultsError, fn -> Fiction.get_chapter!(chapter.id) end
    end

    test "change_chapter/1 returns a chapter changeset" do
      chapter = insert(:chapter)
      assert %Ecto.Changeset{} = Fiction.change_chapter(chapter)
    end
  end
end
