defmodule Derivco.Router do
  @moduledoc """
  Main router of application
  Offer a ping to see is everything is running ok
  """  
  use Plug.Router
  
  alias Derivco.PingController, as: Ping

  plug(:match)
  plug(Derivco.PipelineInstrumenter)
  plug(Derivco.PrometheusExporter)
  plug(:dispatch)

  get("/ping",    do: Ping.ping(conn))
  get("/flunk",   do: Ping.flunk(conn))
  get("/metrics", do: PrometheusExporter.metrics())

  forward("/api", to: Derivco.ApiRouter)

  match _ do
    send_resp(conn, 404, "oops")
  end
end
