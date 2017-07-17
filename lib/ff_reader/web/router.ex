defmodule FfReader.Web.Router do
  use FfReader.Web, :router
  alias FfReader.Web.Auth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :protected do
    plug Guardian.Plug.EnsureAuthenticated, handler: Auth.GuardianHandler
    plug Guardian.Plug.EnsureResource, handler: Auth.GuardianHandler
    plug Auth.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FfReader.Web do
    pipe_through [:browser, :protected]
    resources "/users", UserWriteController, only: [:edit, :update, :delete]
    resources "/stories", StoryChangeController, except: [:show, :index]
  end

  scope "/", FfReader.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:show, :index, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/stories", StoryController, only: [:show, :index]
  end

  # Other scopes may use custom stacks.
  # scope "/api", FfReader.Web do
  #   pipe_through :api
  # end
end
