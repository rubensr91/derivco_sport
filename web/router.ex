defmodule Derivco.Router do
  
  use Plug.Router
  import PlugEtsCache.Response, only: [cache_response: 1]
  alias Derivco.PingController, as: Ping

  # Use plug logger for logging request information
  plug(Plug.Logger)

  plug(:match)
  plug(Derivco.PipelineInstrumenter)
  plug(Derivco.PrometheusExporter)
  plug(:dispatch)

  get "/" do
    Plug.Conn.fetch_query_params(conn)
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello cache")
    |> cache_response
  end  

  get("/ping",    do: Ping.ping(conn))
  get("/flunk",   do: Ping.flunk(conn))

  forward "/api", to: Derivco.ApiRouter

  match _ do
    send_resp(conn, 404, "oops")
  end
end
