import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :peta_stack_example, PetaStackExample.Repo,
  username: "postgres",
  password: "postgres",
  database: "peta_stack_example_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  migration_timestamps: [type: :utc_datetime_usec]

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :peta_stack_example, PetaStackExampleWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
