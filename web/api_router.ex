defmodule Derivco.ApiRouter do
  @moduledoc """
  Api router
  Just call to LaLigaController
  """
  use Plug.Router

  alias Derivco.Api.LaLigaController, as: LaLigaController

  plug(:match)
  plug(:dispatch)

  get("/laliga", do: LaLigaController.run(conn))

  match _ do
    send_resp(conn, 404, "oops")
  end  

end
