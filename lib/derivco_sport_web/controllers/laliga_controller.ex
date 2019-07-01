defmodule DerivcoSportWeb.LaLigaController do
  use DerivcoSportWeb, :controller

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    data = File.read!("data.csv")
    |> String.split("\r\n")
    |> Enum.map(&String.split(&1, ",") |> IO.inspect)

    render(conn, "index.html", data)
  end
end
