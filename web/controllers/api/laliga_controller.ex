defmodule Derivco.Api.LaLigaController do
  @moduledoc """
  Main controller
  Return a json with games result if everything is ok
  or an error if anything fail
  """
  import Plug.Conn
  require Logger

  alias Derivco.Api.LaLigaLogic

  @spec run(Plug.Conn.t(), any) :: Plug.Conn.t()
  def run(conn, _params \\ []) do
    conn.query_string
    |> LaLigaLogic.run()
    |> response(conn)
  end

  @spec response(Tuple, Plug.Conn.t()) :: Plug.Conn.t()
  defp response({:ok, data}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, data)
  end
  defp response({:error, reason}, conn) do
    Logger.error(reason)

    conn
    |> send_resp(400, reason)
  end
end
