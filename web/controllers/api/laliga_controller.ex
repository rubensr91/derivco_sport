defmodule Derivco.Api.LaLigaController do
  @moduledoc """
  Main controller
  Is called from X.X.X.X/api/laliga
  HTML API to provide games result
  Can recieve params to filter the result
  """
  import Plug.Conn
  require Logger
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

  @spec run(Plug.Conn.t(), any) :: Plug.Conn.t()
  def run(conn, _params \\ []) do
    @csv
    |> read_file()
    |> filter_or_not_by_params(conn.query_string)
    |> encode_file()
    |> response(conn)
  end

  # @spec read_file
  defp read_file(file) do
    case File.read(file) do
      {:ok, data} ->
        {:ok,
         data
         |> CSV.parse_string()
         |> Enum.map(fn [
                          _coma,
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
         end)}

      {:error, _} ->
        {:error, "Error reading file"}
    end
  end

  # @spec filter_or_not_by_params
  defp filter_or_not_by_params({:ok, file}, param)
       when is_binary(param) and byte_size(param) > 0 do
    {:ok, Enum.filter(file, &(&1.season == param))}
  end

  defp filter_or_not_by_params({:ok, file}, _params) do
    {:ok, file}
  end

  defp filter_or_not_by_params({:error, _reason} = error, _params), do: error

  # @spec encode_file
  defp encode_file({:ok, file}) do
    {:ok,
     file
     |> Jason.encode!()}
  end

  defp encode_file({:error, _reason} = error), do: error

  # @spec response
  defp response({:ok, data}, conn) do
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
