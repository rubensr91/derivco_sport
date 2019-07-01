defmodule DerivcoSportWeb.Api.LaLigaController do
  use DerivcoSportWeb, :controller

  # defmodule D do
  #   defstruct [:conn, :params, :response, :offer, :ts]
  # end  

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    File.read!("data.csv")
    |> String.split("\r\n")
    |> Enum.map(&String.split(&1, ","))
    |> view_render()
    |> get_body(conn)
  end

  # @spec view_render 
  defp view_render(data_csv) do
    #hay que ver cómo hacer un bucle para listar los datos en el html
    Phoenix.View.render(DerivcoSportWeb.Api.LaLigaView, "index.html", data: data_csv)
  end

  # @spec get_body 
  defp get_body({:safe, data}, conn) do
    data
    |> response(conn)
  end

  # @spec response 
  defp response(data, conn) do
    conn
    |> send_resp(200, data)
  end
end
