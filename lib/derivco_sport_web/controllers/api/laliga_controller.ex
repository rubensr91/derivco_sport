defmodule DerivcoSportWeb.Api.LaLigaController do
  @moduledoc """

  """
  require Logger
  use DerivcoSportWeb, :controller
  alias NimbleCSV.RFC4180, as: CSV

  @csv "data.csv"

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

  def index(conn, params \\ []) do
    @csv
    |> read_file()
    |> filter_or_not_by_params(params)
    |> Jason.encode!()
    |> response(conn)
  end

  # @spec read_file

  defp read_file(file) do
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
          %{
            div: div,
            season: season,
            date: date,
            hometeam: hometeam,
            awayteam: awayteam,
            fthg: fthg,
            ftag: ftag,
            ftr: ftr,
            hthg: hthg,
            htag: htag,
            htr: htr
          }
        end)

      {:error, :enoent} ->
        {:error, "Error reading file"}
    end
  end

  # @spec filter_or_not_by_params
  defp filter_or_not_by_params(file, params) when is_map(params) and map_size(params) > 0 do
    Enum.filter(file, &(&1.season == params["season"]))
  end

  defp filter_or_not_by_params(file, _params), do: file

  # @spec response

  defp response(data, conn) do
    Logger.info("Read file correctly!")

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
