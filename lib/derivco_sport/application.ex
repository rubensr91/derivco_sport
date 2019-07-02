defmodule DerivcoSport.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Metrics setup
    DerivcoSportWeb.Metrics.setup()
    DerivcoSportWeb.PhoenixInstrumenter.setup()
    DerivcoSportWeb.PipelineInstrumenter.setup()
    DerivcoSportWeb.PrometheusExporter.setup()

    commit = :os.cmd('git rev-parse --short HEAD') |> to_string |> String.trim_trailing("\n")
    version = "0.1.0+#{commit}"
    DerivcoSportWeb.Metrics.inc(:git_version, [labels: [version]])

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(DerivcoSport.Repo, []),
      # Start the endpoint when the application starts
      supervisor(DerivcoSportWeb.Endpoint, []),
      # Start your own worker by calling: DerivcoSport.Worker.start_link(arg1, arg2, arg3)
      # worker(DerivcoSport.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DerivcoSport.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DerivcoSportWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
