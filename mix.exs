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
      deps: deps(),
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      extra_applications: [:logger],
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
      {:plug_cowboy, "~> 2.0"},
      {:plug, "~> 1.3"},
      {:prometheus_ex, "~> 3.0"},
      {:prometheus_plugs, "~> 1.1.5"},
      {:nimble_csv, "~> 0.6"},
      {:mix_test_watch, "~> 0.8", only: [:dev, :test], runtime: false},
      {:jason, "~> 1.1.2"},
      {:excoveralls, "~> 0.8", only: :test},
      {:webmachine, git: "https://github.com/webmachine/webmachine.git", branch: "master"},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false}
    ]
  end
end
