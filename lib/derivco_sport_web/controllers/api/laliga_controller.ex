defmodule DerivcoSportWeb.Api.LaLigaController do
  @moduledoc """

  """
  require Logger
  use DerivcoSportWeb, :controller
  alias NimbleCSV.RFC4180, as: CSV

  defmodule State do
    @moduledoc """
      state of application
    """
    defstruct ~w(conn response)a
  end

  defmodule Error do
    @moduledoc """
      error of application
      for example when crash while reading file
    """
    defstruct ~w(state reason)a
  end

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
        data
        |> CSV.parse_string()
        |> Enum.map(fn [
                         coma,
                         div,
                         season,
                         date,
                         hometeam,
                         awayteam,
                         fthg,
                         ftag,
                         ftr,
                         hthg,
                         htag,
                         htr
                       ] ->
          %{date: date, hometeam: hometeam, awayteam: awayteam, fthg: fthg, ftag: ftag}
        end)

      {:error, :enoent} ->
        {:error, "Error reading file"}
    end
  end

  # @spec render_view

  defp render_view(data_csv) do
    IO.inspect(data_csv)
    Phoenix.View.render(DerivcoSportWeb.Api.LaLigaView, "index.html", games: data_csv)
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
