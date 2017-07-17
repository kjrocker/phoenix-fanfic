defmodule FfReader.Web.LoginAs do
  use Phoenix.ConnTest

  @endpoint FfReader.Web.Endpoint

  def login_as(conn, user, token \\ :token, opts \\ []) do
    conn
    |> Phoenix.ConnTest.bypass_through(FfReader.Router, [:browser, :protected])
    |> get("/")
    |> Map.update!(:state, fn (_) -> :set end)
    |> Guardian.Plug.sign_in(user, token, opts)
    |> Plug.Conn.send_resp(200, "Flush the session")
    |> Phoenix.ConnTest.recycle
    |> Plug.Conn.assign(:current_user, user)
  end
end
