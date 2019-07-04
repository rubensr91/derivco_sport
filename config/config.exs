# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :logger, :console,
  format: "$date $time $metadata[$level] $message\n",
  metadata: [:request_id]

config :derivco_sport, ets_cleanup_period: 30 * 60 * 1000
config :derivco_sport,
  ets_tables_persistance: [
    tables: %{
      laliga: :set
    }
  ]

if Mix.env() == :dev do
  config :mix_test_watch,
    tasks: [
      "test --cover",
      "credo --strict"
    ]
end

import_config "#{Mix.env()}.exs"
