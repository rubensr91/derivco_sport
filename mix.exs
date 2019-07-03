defmodule Derivco.Mixfile do
  use Mix.Project

  def project do
    [
      app: :derivco_sport,
      version: "0.2.0",
      elixir: "~> 1.9",
      test_coverage: [tool: ExCoveralls],
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      extra_applications: [:logger, :plug_cowboy, :plug_ets_cache],
      mod: {Derivco, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_), do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [

      {:httpoison, "~> 1.4"},
      {:plug_cowboy,      "~> 2.0"},
      {:plug,             "~> 1.0"},
      {:prometheus_ex, "~> 3.0"},
      {:prometheus_plugs, "~> 1.1.5"},
      {:nimble_csv, "~> 0.6"},
      {:mix_test_watch,   "~> 0.8", only: [:dev, :test], runtime: false},
      {:plug_ets_cache, github: "andreapavoni/plug_ets_cache"},
      {:jason, "~> 1.1.2"},
      # {:credo, "~> 0.4", only: [:dev, :test]},
      {:excoveralls, "~> 0.8", only: :test},
      {:dialyxir, "~> 1.0.0-rc.4", only: [:dev], runtime: false}
    ]
  end

end
