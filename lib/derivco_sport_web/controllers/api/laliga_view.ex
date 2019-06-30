defmodule DerivcoSportWeb.Api.LaLigaView do
  use DerivcoSportWeb, :view

  def render("index.json", %{albums: albums}) do
    %{data: render_many(albums, DerivcoSportWeb.Api.LaLigaView, "data.csv")}
  end

  def render("data.csv", %{album: album}) do
    %{}
  end

  def render("show.json", %{album: album}) do
    %{data: render_one(album, DerivcoSportWeb.Api.LaLigaView, "data.csv")}
  end

end
