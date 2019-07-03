defmodule Derivco.Router do
  
  use Plug.Router
  
  alias Derivco.PingController, as: Ping

  # Use plug logger for logging request information
  plug(Plug.Logger)

  plug(:match)
  plug(Derivco.PipelineInstrumenter)
  plug(Derivco.PrometheusExporter)
  plug(:dispatch)

  get("/ping",    do: Ping.ping(conn))
  get("/flunk",   do: Ping.flunk(conn))

  forward("/api", to: Derivco.ApiRouter)

  match _ do
    send_resp(conn, 404, "oops")
  end
end
