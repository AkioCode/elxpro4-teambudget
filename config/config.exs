# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :team_budget,
  ecto_repos: [TeamBudget.Repo],
  generators: [binary_id: true]

config :team_budget, TeamBudget.Accounts.Core.Guardian,
  issuer: "team_budget",
  secret_key: "pA2NZryiN9KTaNaWURjuEYP/RZv4NkX8PFaBLp2A/AuOyCPYR0bBWUxONgnGoxiM"

# Configures the endpoint
config :team_budget, TeamBudgetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iNh2pYdbDqjp7q9IYK7cwwX03sJ6HTHARr2Ln/713+ucPm5Dyzy3b2X3iGYfvq/L",
  render_errors: [view: TeamBudgetWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: TeamBudget.PubSub,
  live_view: [signing_salt: "N3Hkj6D2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
