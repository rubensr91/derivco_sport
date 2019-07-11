defmodule LaLigaTest do
  @moduledoc false
  use ExUnit.Case
  use Plug.Test

  alias Derivco.Api.{LaLigaController, LaLigaLogic}

  test "testing laliga with bad params" do
    conn = conn(:get, "/api/laliga?season=asd&div=3123")
    conn = Plug.Conn.fetch_query_params(conn)
    conn = LaLigaController.run(conn)

    assert conn.resp_body == Jason.encode!([])
  end

  test "testing laliga bad response" do
    conn = conn(:get, "/api/laliga")
    conn = LaLigaController.response({:error, "error from test"}, conn)

    assert conn.resp_body == "error from test"
  end

  test "testing laliga filter_or_not_by_season" do
    conn = conn(:get, "/api/laliga?season=asd&div=3123")
    conn = Plug.Conn.fetch_query_params(conn)
    {:error, reason} = LaLigaLogic.filter_or_not_by_season({:error, "error from test"}, "")

    assert reason == "error from test"
  end

  test "testing laliga filter_or_not_by_div" do
    conn = conn(:get, "/api/laliga")
    conn = Plug.Conn.fetch_query_params(conn)
    {:error, reason} = LaLigaLogic.filter_or_not_by_div({:error, "error from test"}, "")

    assert reason == "error from test"
  end

  test "testing laliga encode_file" do
    conn = conn(:get, "/api/laliga")
    {:error, reason} = LaLigaLogic.encode_file({:error, "error from test"})

    assert reason == "error from test"
  end
end
