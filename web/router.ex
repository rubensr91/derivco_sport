defmodule Derivco.Web.Router do
  @moduledoc """
  Main router of application
  Offer a ping to see is everything is running ok
  """
  use Plug.Router

  alias Derivco.PingController, as: Ping
  alias Derivco.VersionController, as: Version

  plug(:match)
  plug(Derivco.Metrics.Instrumenter)
  plug(Derivco.Metrics.Exporter)
  plug(:dispatch)

  get("/ping",    do: Ping.ping(conn))
  get("/flunk",   do: Ping.flunk(conn))
  get("/metrics", do: PrometheusExporter.metrics(conn))
  get("/version", do: Version.run(conn))

  forward("/api", to: Derivco.ApiRouter)

  match _ do
    send_resp(conn, 404, "oops")
  end
end
