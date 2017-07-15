defmodule FfReader.Web.Router do
  use FfReader.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.EnsureAuthenticated, handler: FfReader.Accounts.Token
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FfReader.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, except: [:update, :delete]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/", FfReader.Web do
    pipe_through [:browser, :browser_auth]
    resources "/users", UserController, except: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", FfReader.Web do
  #   pipe_through :api
  # end
end
