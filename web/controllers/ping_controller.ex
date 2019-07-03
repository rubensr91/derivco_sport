defmodule Derivco.PingController do
  @moduledoc """
  This controller contains the ping and flunk functions, this functions are
  for verify if derivco is up (ping) or to force an error (flunk).
  """
  import Plug.Conn

  def init(_) do
    {:ok, nil}
  end

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

  def to_html(req_data, state) do
    commit = :os.cmd('git rev-parse --short HEAD') |> to_string |> String.trim_trailing("\n")

    {"<html><body>I show you the version of this project with web machine => " <>
       "0.1.0+#{commit}" <> "</body></html>", req_data, state}
  end
end
