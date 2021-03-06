# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ff_reader,
  ecto_repos: [FfReader.Repo]

# Configures the endpoint
config :ff_reader, FfReader.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JdD8y/eQkVHb9nhEeXFrTqWu7df4wJOcWMEo/trwTkHRm40eZJnXIVkeLw2hpfQS",
  render_errors: [view: FfReader.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FfReader.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "FFReader",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: "3wrvyle6KH6S8y77mH5i2FyIk6/benHEpsZmam4ilM/LNQNZZXkCptMTb00RTFUA",
  serializer: FfReader.Web.Auth.GuardianSerializer

config :canary,
  repo: FfReader.Repo,
  unauthorized_handler: {FfReader.Web.Auth.Canary, :handle_unauthorized},
  not_found_handler: {FfReader.Web.Auth.Canary, :handle_not_found}

config :scrivener_html,
  routes_helper: FfReader.Router.Helpers

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
