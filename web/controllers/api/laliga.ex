defmodule LaLigaLogic do
  @moduledoc """
  Logic of LaLigaController
  """

  require Logger
  alias NimbleCSV.RFC4180, as: CSV

  def run(params, file) do
    file
    |> read_file()
    |> filter_or_not_by_params(params)
    |> encode_file()    
  end

  @spec read_file(String.t) :: List | Tuple
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

end