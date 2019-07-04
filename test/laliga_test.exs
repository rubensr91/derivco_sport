defmodule LaLigaTest do
  @moduledoc false
  use ExUnit.Case
  use Plug.Test

  alias Derivco.Api.{LaLigaLogic, LaLigaController}

  test "testing laliga with bad params" do
    conn = conn(:get, "/api/laliga?bad&gdfgndljfkhng&f28f723fh/")
    conn = LaLigaController.run(conn)

    assert conn.resp_body == Jason.encode!([])
  end

  test "testing laliga bad response" do
    conn = conn(:get, "/api/laliga")
    conn = LaLigaController.response({:error, "error from test"}, conn)

    assert conn.resp_body == "error from test"
  end

  test "testing laliga filter_or_not_by_params" do
    conn = conn(:get, "/api/laliga")
    {:error, reason} = LaLigaLogic.filter_or_not_by_params({:error, "error from test"}, "")

    assert reason == "error from test"
  end  

  test "testing laliga encode_file" do
    conn = conn(:get, "/api/laliga")
    {:error, reason} = LaLigaLogic.encode_file({:error, "error from test"})

    assert reason == "error from test"
  end  
end
