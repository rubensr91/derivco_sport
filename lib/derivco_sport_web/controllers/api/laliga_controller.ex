defmodule DerivcoSportWeb.Api.LaLigaController do
  use DerivcoSportWeb, :controller

  # defmodule D do
  #   defstruct [:conn, :params, :response, :offer, :ts]
  # end  

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    data = File.read!("data.csv")
    |> String.split("\r\n")
    |> Enum.map(&String.split(&1, ","))
    |> renderiza(conn)
  end

  defp renderiza(data, conn) do
    data = Phoenix.View.render(DerivcoSportWeb.Api.LaLigaView, "index.html", name: "John Doe")
    |> get_body(conn)
  end

  defp get_body({:safe, data}, conn) do
    data
    |> response(conn)
  end

  defp response(data, conn) do
    conn
    |> send_resp(200, data)
  end
end
