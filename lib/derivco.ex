defmodule Derivco do
  @moduledoc """
  """

  use Application

  alias Plug.Cowboy
  alias DerivcoSport.Router

  def start(_type, _args) do
    # Metrics.setup()
    # PipelineInstrumenter.setup()
    # PrometheusExporter.setup()

    children = [
      Cowboy.child_spec(
        scheme: :http,
        plug: Router,
        options: [port: Application.get_env(:derivco_sport, :port)]
      )
    ]

    opts = [strategy: :one_for_one, name: DerivcoSport.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
