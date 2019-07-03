defmodule Derivco.ApiRouter do

  use Plug.Router

  alias Derivco.Api.LaLigaController, as: LaLiga

  # Use plug logger for logging request information
  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  get("/laliga", do: LaLiga.run(conn))

  match _ do
    send_resp(conn, 404, "oops")
  end  

end
