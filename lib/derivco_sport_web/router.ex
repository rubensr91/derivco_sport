defmodule DerivcoSportWeb.Router do
  use DerivcoSportWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DerivcoSportWeb do
    pipe_through :browser # Use the default browser stack

    get "/laliga", LaLigaController, :index
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", DerivcoSportWeb.Api, as: :api do
    pipe_through :api

    resources "/laliga", LaLigaController, only: [:show, :index]
  end

end
