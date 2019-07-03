defmodule Derivco do
  @moduledoc """
  Start application and setup metrics
  """

  use Application

  alias Plug.Cowboy
  alias Derivco.VersionController
  alias Derivco.Metrics
  alias Derivco.Web.Router
  alias Derivco.Metrics.{Exporter, Instrumenter}

  def start(_type, _args) do
    Metrics.setup()
    Exporter.setup()
    Instrumenter.setup()

    Metrics.inc(:version, labels: [VersionController.get_commit_version()])

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
