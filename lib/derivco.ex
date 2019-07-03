defmodule Derivco do
  @moduledoc """
  """

  use Application

  alias Plug.Cowboy
  alias Derivco.{Metrics, PipelineInstrumenter, PrometheusExporter, Router}

  def start(_type, _args) do
    Metrics.setup()
    PipelineInstrumenter.setup()
    PrometheusExporter.setup()

    commit = :os.cmd('git rev-parse --short HEAD') |> to_string |> String.trim_trailing("\n")
    v = "0.1.0+#{commit}"
    Metrics.inc(:git_version, [labels: [v]])

    children = [
      Cowboy.child_spec(
        scheme: :http,
        plug: Router,
        options: [port: Application.get_env(:derivco_sport, :port)]
      )
    ]

    opts = [strategy: :one_for_one, name: Derivco.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
