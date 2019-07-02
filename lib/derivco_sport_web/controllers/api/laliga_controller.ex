
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
    case File.read(file) do
      {:ok, data} -> 
        {:ok, String.split(data, "\r\n")}
      {:error, :enoent} ->
        {:error, "Error reading file"}
    end
  end

  # @spec render_view
  defp render_view({:ok, data_csv}) do
    Phoenix.View.render(DerivcoSportWeb.Api.LaLigaView, "index.html", data: data_csv)
  end
  defp render_view({:error, _reason} = error), do: error

  # @spec get_body
  defp get_body({:safe, data}) do
    {:ok, data}
  end
  defp get_body({:error, _reason} = error), do: error

  # @spec response
  defp response({:ok, data}, conn) do
    Logger.info("Read file correctly!")

    conn
    |> send_resp(200, data)
  end
  defp response({:error, reason}, conn) do
    Logger.error(reason)

    conn
    |> send_resp(400, reason)
  end  
end
