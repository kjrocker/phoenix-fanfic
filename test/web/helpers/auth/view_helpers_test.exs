defmodule FfReader.Web.ViewHelperTest do
  use FfReader.Web.ConnCase

  test "prevent current_user regression", %{conn: conn} do
    user = string_params_for(:user, %{password: "password"})
    conn = post(conn, "/users", %{"user" => user})
    assert get(conn, "/")
  end
end
