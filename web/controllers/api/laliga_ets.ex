defmodule Derivco.Api.LaLigaEts do

    require Logger

  @ets_table :laliga

  def lookup_all() do
    Logger.info "look up all"
    :ets.foldl(
      fn item, acc ->
        acc ++ [item]
      end,
      [],
      @ets_table
    )
  end

  def insert(row) do
    :ets.insert(@ets_table, row)
  end

  def delete_all() do
    Logger.info "delete table"
    :ets.delete_all_objects(@ets_table)
  end  
end