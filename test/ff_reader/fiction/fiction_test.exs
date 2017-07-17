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
      assert Fiction.get_story!(story.id) == story
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
      assert {:error, %Ecto.Changeset{}} = Fiction.update_story(story, @invalid_attrs)
      assert story == Fiction.get_story!(story.id)
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
end
