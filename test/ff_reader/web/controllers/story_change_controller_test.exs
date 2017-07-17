defmodule FfReader.Web.StoryChangeControllerTest do
  use FfReader.Web.ConnCase

  @update_attrs %{summary: "some updated summary", title: "some updated title"}
  @invalid_attrs %{summary: nil, title: nil}

  def story_with_chapter(attrs \\ []) do
     story = insert(:story, attrs)
     insert(:chapter, story: story)
     story
  end

  describe "any authentication" do
    test "renders form for new stories", %{conn: conn} do
      conn = login_as(conn, insert(:user))
      conn = get conn, story_change_path(conn, :new)
      assert html_response(conn, 200) =~ "New Story"
    end

    @tag :skip # Problems with factories and associations
    test "creates story and redirects when data is valid", %{conn: conn} do
      author = insert(:user)
      create_attrs = params_for(:story)
      conn = login_as(conn, author)
      conn = post conn, story_change_path(conn, :create), story: create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == story_path(conn, :show, id)

      conn = get conn, story_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Story"
    end

    test "does not create story and renders errors when data is invalid", %{conn: conn} do
      user = insert(:user)
      conn = login_as(conn, user)
      invalid_attrs = params_for(:story, title: nil, summary: nil)
      conn = post conn, story_change_path(conn, :create), story: invalid_attrs
      assert html_response(conn, 200) =~ "New Story"
    end
  end

  describe "incorrectly authenticated" do
    test "doesn't render form for editing chosen story", %{conn: conn} do
      story = insert(:story)
      lurker = insert(:user)
      conn = login_as(conn, lurker)

      conn = get conn, story_change_path(conn, :edit, story)
      assert html_response(conn, 302)
    end

    test "doesn't update chosen story", %{conn: conn} do
      story = insert(:story)
      user = insert(:user)

      conn = login_as(conn, user)
      conn = put conn, story_change_path(conn, :update, story), story: @update_attrs
      assert html_response(conn, 302)
    end

    test "doesn't delete chosen story", %{conn: conn} do
      story = story_with_chapter()
      user = insert(:user)
      conn = login_as(conn, user)

      conn = delete conn, story_change_path(conn, :delete, story)
      assert html_response(conn, 302)
      assert get(conn, story_path(conn, :show, story))
    end
  end

  describe "correctly authenticated" do
    test "renders form for editing chosen story", %{conn: conn} do
      user = insert(:user)
      conn = login_as(conn, user)
      story = insert(:story, author: user)
      conn = get conn, story_change_path(conn, :edit, story)
      assert html_response(conn, 200) =~ "Edit Story"
    end

    test "updates chosen story and redirects when data is valid", %{conn: conn} do
      user = insert(:user)
      conn = login_as(conn, user)
      story = story_with_chapter(author: user)
      conn = put conn, story_change_path(conn, :update, story), story: @update_attrs
      assert redirected_to(conn) == story_path(conn, :show, story)

      conn = get conn, story_path(conn, :show, story)
      assert html_response(conn, 200) =~ "some updated summary"
    end

    test "does not update chosen story and renders errors when data is invalid", %{conn: conn} do
      user = insert(:user)
      conn = login_as(conn, user)
      story = insert(:story, author: user)
      conn = put conn, story_change_path(conn, :update, story), story: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Story"
    end

    test "deletes chosen story", %{conn: conn} do
      user = insert(:user)
      conn = login_as(conn, user)
      story = insert(:story, author: user)
      conn = delete conn, story_change_path(conn, :delete, story)
      assert redirected_to(conn) == story_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, story_path(conn, :show, story)
      end
    end
  end
end
