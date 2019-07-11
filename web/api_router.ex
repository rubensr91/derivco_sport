defmodule Derivco.ApiRouter do
  @moduledoc """
  Api router
  Just call to LaLigaController
  """
  import Plug.Conn
  use Plug.Router

  alias Derivco.Api.LaLigaController, as: LaLigaController

  plug(:match)
  plug(:dispatch)

  get "/laliga" do
    conn = Plug.Conn.fetch_query_params(conn)
    LaLigaController.run(conn)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

end
