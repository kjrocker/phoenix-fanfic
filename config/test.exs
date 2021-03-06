use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ff_reader, FfReader.Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :ff_reader, FfReader.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "password",
  database: "ff_reader_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :ff_reader, FfReader.Mailer,
  adapter: Bamboo.TestAdapter
