# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :logger, :console,
  format: "$date $time $metadata[$level] $message\n",
  metadata: [:request_id]

config :plug_ets_cache,
  db_name: :laliga,
  ttl_check: 60,
  ttl: 300

if Mix.env == :dev do
  config :mix_test_watch,
    tasks: [
      "test --cover",
      "credo --strict",
    ]
end

import_config "#{Mix.env()}.exs"
