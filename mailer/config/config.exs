# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mailer,
  ecto_repos: [Mailer.Repo]

# Configures the endpoint
config :mailer, MailerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Y65m1K0vl5A0GTnjVMWFmQh2bDaoPSiyXWOa/Z2GGj7FFN3decSIPxlQklO8qziC",
  render_errors: [view: MailerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Mailer.PubSub,
  live_view: [signing_salt: "NUx2nTI+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
