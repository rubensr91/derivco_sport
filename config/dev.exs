use Mix.Config

config :derivco_sport, port: 4001

config :logger, :console, format: "[$level] $message\n"

config :mix_test_watch,
tasks: [
    "test --cover",
    "credo --strict"
]