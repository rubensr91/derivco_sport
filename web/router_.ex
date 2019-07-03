# defmodule DerivcoSport.Web.Router do

#   use Plug.Router
#   alias DerivcoSportWeb.Api.LaLigaController, as: D


#   plug(Plug.Logger)
#   plug(:match)
#   plug(:dispatch)

#   get("/", LaLigaController, :index)
#   get "/", do: D.run(conn)

#   match _ do
#     send_resp(conn, 404, "oops.. Nothing here :(")
#   end
# end
