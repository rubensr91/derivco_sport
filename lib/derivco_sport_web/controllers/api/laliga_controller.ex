
defmodule DerivcoSportWeb.Api.LaLigaController do
  require Logger
  use DerivcoSportWeb, :controller

  # defmodule D do
  #   defstruct [:conn, :params, :response, :offer, :ts]
  # end

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    read_and_split_file("data.csv")
    |> render_view()
    |> get_body()
    |> response(conn)
  end

  # @spec read_and_split_file
  defp read_and_split_file(file) do
    case File.read!(file) do
      {:ok, data} -> 
        String.split(data, "\r\n")
      {:error, _reason} -> 
        Logger.error("Error reading file")
    end
    
  end

  # @spec render_view
  defp render_view(data_csv) do
    #hay que ver cómo hacer un bucle para listar los datos en el html
    Phoenix.View.render(DerivcoSportWeb.Api.LaLigaView, "index.html", data: data_csv)
  end

  # @spec get_body
  defp get_body({:safe, data}) do
    data
  end

  # @spec response
  defp response(data, conn) do
    conn
    |> send_resp(200, data)
  end
end
