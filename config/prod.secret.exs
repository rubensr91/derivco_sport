use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :derivco_sport, DerivcoSportWeb.Endpoint,
  secret_key_base: "sAdDnH/nSPcCBpyUgsWzZg52aEm7vamVUILuw2hh6xEkKyZLL45FHKbHgzFvH2Ul"

# Configure your database
config :derivco_sport, DerivcoSport.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "derivco_sport_prod",
  pool_size: 15
