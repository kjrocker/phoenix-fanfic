defmodule FfReader.Web.UserWriteControllerTest do
  use FfReader.Web.ConnCase

  describe "unauthenticated" do
    test "GET /users/:id/edit", %{conn: conn} do
      user = insert(:user)
      conn = get conn, "/users/#{user.id}/edit"
      assert html_response(conn, 302)
    end

    test "PUT /users/:id/", %{conn: conn} do
      user = insert(:user)
      conn = put conn, "/users/#{user.id}", string_params_for(:user)
      assert html_response(conn, 302)
    end

    test "PATCH /users/:id/", %{conn: conn} do
      user = insert(:user)
      conn = patch conn, "/users/#{user.id}", string_params_for(:user)
      assert html_response(conn, 302)
    end
  end

  describe "incorrectly authenticated" do
    test "GET /users/:id/edit", %{conn: conn} do
      right_user = insert(:user)
      wrong_user = insert(:user)
      conn = get login_as(conn, right_user), "/users/#{wrong_user.id}/edit"
      assert html_response(conn, 302)
    end

    test "PUT /users/:id/", %{conn: conn} do
      right_user = insert(:user)
      wrong_user = insert(:user)
      conn = put login_as(conn, right_user), "/users/#{wrong_user.id}", string_params_for(:user)
      assert html_response(conn, 302)
    end

    test "PATCH /users/:id/", %{conn: conn} do
      right_user = insert(:user)
      wrong_user = insert(:user)
      conn = patch login_as(conn, right_user), "/users/#{wrong_user.id}", string_params_for(:user)
      assert html_response(conn, 302)
    end
  end

  describe "correctly authenticated" do
    test "GET /users/:id/edit", %{conn: conn} do
      user = insert(:user)
      conn = get login_as(conn, user), "/users/#{user.id}/edit"
      assert html_response(conn, 200)
    end

    test "PUT /users/:id/", %{conn: conn} do
      user = insert(:user)
      # IO.inspect user
      params = string_params_for(:user)
      # IO.inspect params
      conn = login_as(conn, user)
      conn = put login_as(conn, user), "/users/#{user.id}", %{"user" => params}
      assert html_response(conn, 200)
    end

    test "PATCH /users/:id/", %{conn: conn} do
      user = insert(:user)
      params = string_params_for(:user)
      conn = login_as(conn, user)
      conn = patch conn, "/users/#{user.id}", %{"user" => params}
      assert html_response(conn, 200)
    end
  end
end
