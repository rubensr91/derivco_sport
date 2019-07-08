defmodule Derivco.Api.LaLigaLogic do
  @moduledoc """
  I have decide to read the file this way because I think is fast and easy
  With this you read the file just when you compile the app
  I know is not the best way because you have to recompile if you change the file
  Logic of LaLigaController
  Read the csv file and make a map,
  if ok return a map else return a tuple
  then, if params is not empty, filter the result and return
  """

  require Logger
  alias NimbleCSV.RFC4180, as: CSV

  @data "data.csv" |> File.read! |> CSV.parse_string()
         |> Enum.map(fn [_coma,div,season,date,hometeam,awayteam,fthg,ftag,ftr,hthg,htag,htr] -> 
          %{div: div,season: season,date: date,hometeam: hometeam,awayteam: awayteam,fthg: fthg,ftag: ftag,
             ftr: ftr,hthg: hthg,htag: htag,htr: htr}
         end)

  @spec run(%Plug.Conn{} | []) :: {:error, <<_::144>>} | {:ok, binary()}

  def run(conn) do
    filter_or_not_by_season(@data, conn.query_params["season"])
    |> filter_or_not_by_div(conn.query_params["div"])
    |> encode_file()
  end

  @spec filter_or_not_by_season({:error, <<_::144>>} | any(), <<_::144>>) ::
          {:error, <<_::144>>} | {:ok, [any()]}

  def filter_or_not_by_season({:error, _reason} = error, _params), do: error
  def filter_or_not_by_season(file, season)
       when is_binary(season) and byte_size(season) > 0 do
    {:ok, Enum.filter(file, &(&1.season == season))}
  end
  def filter_or_not_by_season(file, _params), do: {:ok, file}

  @spec filter_or_not_by_div({:error, <<_::144>>} | {:ok, [any()]}, <<_::144>>) ::
          {:error, <<_::144>>} | {:ok, [any()]}

  def filter_or_not_by_div({:error, _reason} = error, _params), do: error
  def filter_or_not_by_div({:ok, file}, div)
       when is_binary(div) and byte_size(div) > 0 do
    {:ok, Enum.filter(file, &(&1.div == div))}
  end
  def filter_or_not_by_div({:ok, file}, _params), do: {:ok, file}    
  
  @spec encode_file({:error, <<_::144>>} | {:ok, [any()]}) ::
          {:error, <<_::144>>} | {:ok, binary()}

  def encode_file({:ok, file}) do
    {:ok,
     file
     |> Jason.encode!()}
  end
  def encode_file({:error, _reason} = error), do: error
end