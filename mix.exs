defmodule DerivcoSport.Mixfile do
  use Mix.Project

  def project do
    [
      app: :derivco_sport,
      version: "0.1.0",
      elixir: "~> 1.9",
      test_coverage: [tool: ExCoveralls],
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {DerivcoSport.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix,                      "~> 1.4.8"  },
      {:phoenix_pubsub,               "~> 1.0"    },
      {:phoenix_ecto,                 "~> 3.2"    },
      {:postgrex,                     ">= 0.0.0"  },
      {:phoenix_html,                 "~> 2.10"   },
      {:phoenix_live_reload,          "~> 1.0",           only: :dev},
      {:gettext,                      "~> 0.11"   },
      {:plug_cowboy,                  "~> 1.0"    },
      {:cowboy,                       "~> 1.0"    },
      {:httpoison,                    "~> 1.5.1",         override: true  },
      {:poison,                       "~> 2.2"    },
      {:exprotobuf,                   "~> 1.2.9"  },
      {:prometheus,                   "~> 4.0"    },
      {:prometheus_ex,                "~> 3.0"    },
      {:prometheus_phoenix,           "~> 1.2.1"  },
      {:prometheus_plugs,             "~> 1.1.5"  },
      {:prometheus_process_collector, "~> 1.3"    },
      {:credo,                        "~> 0.4",           only: [:dev, :test] },
      {:excoveralls,                  "~> 0.8",           only: :test },
      {:dialyxir,                     "~> 1.0.0-rc.4",    only: [:dev], runtime: false }
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
