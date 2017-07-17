defmodule FfReader.Web.StoryControllerTest do
  use FfReader.Web.ConnCase

  @update_attrs %{summary: "some updated summary", title: "some updated title"}
  @invalid_attrs %{summary: nil, title: nil}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, story_path(conn, :index)
    assert html_response(conn, 200) =~ "Available Stories"
  end

  describe "unauthenticated" do
    test "redirects new story page", %{conn: conn} do
      conn = get conn, story_change_path(conn, :new)
      assert html_response(conn, 302)
    end

    test "redirects edit story page", %{conn: conn} do
      story = insert(:story)
      conn = get conn, story_change_path(conn, :edit, story)
      assert html_response(conn, 302)
    end

    test "fails create action", %{conn: conn} do
      create_attrs = params_for(:story)
      conn = post conn, story_change_path(conn, :create), story: create_attrs
      assert html_response(conn, 302)
    end

    test "fails update action", %{conn: conn} do
      story = insert(:story)
      conn = put(conn, story_change_path(conn, :update, story),
        story: string_params_for(:story))
      assert html_response(conn, 302)
    end

    test "fails delete action", %{conn: conn} do
      story = insert(:story)
      conn = delete(conn, story_change_path(conn, :delete, story))
      assert html_response(conn, 302)
    end
  end
end
