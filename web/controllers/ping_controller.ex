defmodule Derivco.PingController do
  @moduledoc """
  This controller contains the ping and flunk functions, this functions are
  for verify if derivco is up (ping) or to force an error (flunk).
  """
  import Plug.Conn

  @spec ping(%Plug.Conn{}) :: %Plug.Conn{}

  def ping(conn) do
    conn
    |> put_resp_header("content-type", "text/plain")
    |> send_resp(200, "Pong")
  end

  @spec flunk(%Plug.Conn{}) :: %Plug.Conn{}

  def flunk(conn) do
    conn
    |> put_resp_header("content-type", "text/plain")
    |> send_resp(500, "Booom!!")
  end
end
