# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fanfic,
  ecto_repos: [Fanfic.Repo]

# Configures the endpoint
config :fanfic, FanficWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BF0n0gv78QQkwPdQMCMS31ORarFPACZH55XFc2zoWRP6cZ9WJMXaqlnkcFgqJINW",
  render_errors: [view: FanficWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Fanfic.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Fanfic.Accounts.User,
  repo: Fanfic.Repo,
  user_token: true,
  module: Fanfic,
  web_module: FanficWeb,
  router: FanficWeb.Router,
  messages_backend: FanficWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:rememberable, :authenticatable, :recoverable, :lockable, :unlockable_with_token, :confirmable, :registerable]

config :coherence, FanficWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
