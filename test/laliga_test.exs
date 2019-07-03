defmodule LaLigaTest do
  @moduledoc false
  use ExUnit.Case
  use Plug.Test

  alias Derivco.Api.{LaLigaLogic, LaLigaController}

  test "testing laliga bad file" do
    conn = conn(:get, "/api/laliga")
    response = LaLigaLogic.run(conn, "asd.sd")

    assert response == {:error, "Error reading file"}
  end

  test "testing laliga with params" do
    conn = conn(:get, "/api/laliga?bad&gdfgndljfkhng&f28f723fh/")
    conn = LaLigaController.run(conn)

    assert conn.resp_body == Jason.encode!([])
  end

end
