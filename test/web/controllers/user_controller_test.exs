defmodule FfReader.Web.UserControllerTest do
  use FfReader.Web.ConnCase

  test "GET /users", %{conn: conn} do
    conn = get conn, "/users"
    assert html_response(conn, 200) =~ "Authors"
  end

  test "GET /users/:id", %{conn: conn} do
    user = insert(:user)
    conn = get conn, "/users/#{user.id}"
    assert html_response(conn, 200)
  end
end
