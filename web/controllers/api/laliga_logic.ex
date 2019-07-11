defmodule Derivco.Api.LaLigaLogic do
  @moduledoc """
  I have decide to read the file this way because I think is fast and easy
  With this you read the file just when you compile the app
  I know is not the best way because you have to recompile if you change the file
  Logic of LaLigaController
  First load data from csv file and make a map
  Then validate if params
  if ok return a map with filters data else return an error
  """

  require Logger
  alias NimbleCSV.RFC4180, as: CSV

  @data "data.csv"
        |> File.read!()
        |> CSV.parse_string()
        |> Enum.map(fn [_coma, div, season, date, hometeam, awayteam,
          fthg, ftag, ftr, hthg, htag, htr] ->
          %{div: div, season: season, date: date, hometeam: hometeam,
            awayteam: awayteam, fthg: fthg, ftag: ftag, ftr: ftr,
            hthg: hthg, htag: htag, htr: htr}
        end)

  @spec run(%Plug.Conn{} | []) :: Tuple

  def run(conn) do
    Logger.info("Running application")

    @data
    |> validate_params(conn.query_params)
    |> filter()
    |> encode_file()
  end

  @spec validate_params(String.t(), Map) :: Tuple

  def validate_params(data, params) do
    case is_map(params) and map_size(params) > 0 do
      true -> {:ok, data, params}
      false -> {:ko, "No filters found"}
    end
  end

  @spec filter(Tuple) :: Tuple

  def filter({:ok, data, params}) do
    data
    |> filter_or_not_by_season(params["season"])
    |> filter_or_not_by_div(params["div"])
  end

  def filter({:ko, reason} = error) do
    error
    |> encode_file()
  end

  @spec filter_or_not_by_season(Tuple | String.t(), String.t()) :: Tuple

  def filter_or_not_by_season({:error, _reason} = error, _params), do: error

  def filter_or_not_by_season(file, season)
      when is_binary(season) and byte_size(season) > 0 do
    Logger.info("Filtering by season => #{inspect(season)}")

    {:ok, Enum.filter(file, &(&1.season == season))}
  end

  def filter_or_not_by_season(file, _season) do
    {:ok, file}
  end

  @spec filter_or_not_by_div(Tuple | String.t(), String.t()) :: Tuple

  def filter_or_not_by_div({:error, _reason} = error, _params), do: error

  def filter_or_not_by_div({:ok, file}, div)
      when is_binary(div) and byte_size(div) > 0 do
    Logger.info("Filtering by division => #{inspect(div)}")

    {:ok, Enum.filter(file, &(&1.div == div))}
  end

  def filter_or_not_by_div({:ok, file}, _season) do
    {:ok, file}
  end

  @spec encode_file(Tuple) :: Tuple

  def encode_file({:ok, file}) do
    Logger.info("Encondig #{Enum.count(file)} results")

    {:ok,
     file
     |> Jason.encode!()}
  end

  def encode_file({:ko, reason} = error) do
    {:ko, reason}
  end

  def encode_file({:error, reason} = error) do
    error
  end
end
