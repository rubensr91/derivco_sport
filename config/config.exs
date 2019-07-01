# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :derivco_sport,
  ecto_repos: [DerivcoSport.Repo]

# Configures the endpoint
config :derivco_sport, DerivcoSportWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "M+D7LYYAdBcg7vvvFATsdj7WIpgki5s2KeCaDrZUhhoc3USt9Imq8AKK+//vH8Kr",
  render_errors: [view: DerivcoSportWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DerivcoSport.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
