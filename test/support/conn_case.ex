defmodule FfReader.Web.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common datastructures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import FfReader.Web.Router.Helpers
      import FfReader.Web.LoginAs
      import FfReader.Factory

      # The default endpoint for testing
      @endpoint FfReader.Web.Endpoint
    end
  end


  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(FfReader.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(FfReader.Repo, {:shared, self()})
    end
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  # def login_as(conn, user, token \\ :token, opts \\ []) do
  #   conn
  #   |> Phoenix.ConnTest.bypass_through(FfReader.Router, [:browser, :protected])
  #   |> Phoenix.ConnTest.get("/")
  #   |> Map.update!(:state, fn (_) -> :set end)
  #   |> Guardian.Plug.sign_in(user, token, opts)
  #   |> Plug.Conn.send_resp(200, "Flush the session")
  #   |> Phoenix.ConnTest.recycle
  #   |> Plug.Conn.assign(:current_user, user)
  # end
end
