defmodule Derivco do
  @moduledoc """
  Start application and setup metrics
  """

  use Application
  require Logger
  alias Plug.Cowboy
  alias Derivco.VersionController
  alias Derivco.Metrics
  alias Derivco.Web.Router
  alias Derivco.Metrics.{Exporter, Instrumenter}

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Logger.info("Starting application!")

    Metrics.setup()
    Exporter.setup()
    Instrumenter.setup()

    Metrics.inc(:version, labels: [VersionController.get_commit_version()])

    # webmachine config
    web_config = [
      ip: {127, 0, 0, 1},
      port: 8080,
      dispatch: [
        {[], Derivco.PingController, []}
      ]
    ]

    # webmachine children
    web_machine_children = [
      worker(:webmachine_mochiweb, [web_config],
        function: :start,
        modules: [:mochiweb_socket_server]
      )
    ]

    children = [
      Cowboy.child_spec(
        scheme: :http,
        plug: Router,
        options: [port: Application.get_env(:derivco_sport, :port)]
      )
    ]

    opts = [strategy: :one_for_one, name: Derivco.Supervisor]
    Supervisor.start_link(children ++ web_machine_children, opts)
  end
end
