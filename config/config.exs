# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :octos,
  ecto_repos: [Octos.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :octos, OctosWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: OctosWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Octos.PubSub,
  live_view: [signing_salt: "A/21L7FV"]

config :octos, Octos.Repo,
  migration_primary_key: [type: :uuid],
  migration_timestamps: [type: :utc_datetime_usec]

config :octos, Octos.Guardian,
  issuer: "octos",
  secret_key: "qeclJH0Dh9wwhGmJ4j+Vz2vit+Q0bzdN1/ntdzoXKZhaz46046DKrcOtD0j/zTfJ"

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :octos, Octos.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
