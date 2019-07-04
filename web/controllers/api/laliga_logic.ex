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

  @spec run(binary() | []) :: {:error, <<_::144>>} | {:ok, binary()}

  def run(params) do
    filter_or_not_by_params(@data, params)
    |> encode_file()
  end

  @spec filter_or_not_by_params({:error, <<_::144>>} | {:ok, [any()]}, <<_::144>>) ::
          {:error, <<_::144>>} | {:ok, [any()]}

  defp filter_or_not_by_params(file, param)
       when is_binary(param) and byte_size(param) > 0 do
    {:ok, Enum.filter(file, &(&1.season == param))}
  end
  defp filter_or_not_by_params(file, _params), do: {:ok, file}
  defp filter_or_not_by_params({:error, _reason} = error, _params), do: error

  @spec encode_file({:error, <<_::144>>} | {:ok, [any()]}) ::
          {:error, <<_::144>>} | {:ok, binary()}

  defp encode_file({:ok, file}) do
    {:ok,
     file
     |> Jason.encode!()}
  end
  defp encode_file({:error, _reason} = error), do: error
end