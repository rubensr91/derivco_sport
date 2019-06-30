defmodule DerivcoSportWeb.Api.LaLigaController do
  use DerivcoSportWeb, :controller

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    File.read!("data.csv")
    |> String.split("\r\n")
    |> Enum.map(&String.split(&1, ",") |> IO.inspect)

    conn
  end

end
