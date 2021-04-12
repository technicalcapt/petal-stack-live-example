# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :peta_stack_example,
  ecto_repos: [PetaStackExample.Repo]

# Configures the endpoint
config :peta_stack_example, PetaStackExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cQbqRwUGoPUDLhg2EVMO/oAfdCTtyR5SBZ7MFi3Hd2QuA0qE6wpeS0K9gOlTwAgC",
  render_errors: [view: PetaStackExampleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PetaStackExample.PubSub,
  live_view: [signing_salt: "3xWK8hoG"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
