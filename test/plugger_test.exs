defmodule DerivcoTest do
  @moduledoc false
  use ExUnit.Case
  use Plug.Test

  alias Derivco.Web.Router
  alias Derivco.PingController

  @opts Router.init([])

  test "returns pong" do
    # Create a test connection
    conn = conn(:get, "/ping")

    # Invoke the plug
    conn = Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Pong"
  end

  test "testing to_html" do
    PingController.to_html("", "")
  end

  test "returns flunk" do
    # Create a test connection
    conn = conn(:get, "/flunk")

    # Invoke the plug
    conn = Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 500
    assert conn.resp_body == "Booom!!"
  end

  test "returns version" do
    # Create a test connection
    conn = conn(:get, "/version")

    # Invoke the plug
    conn = Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
  end

  test "returns api" do
    # Create a test connection
    conn = conn(:get, "/api/laliga")

    # Invoke the plug
    conn = Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
  end

  test "returns bad api" do
    # Create a test connection
    conn = conn(:get, "/api/bad")

    # Invoke the plug
    conn = Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == "oops"
  end

  test "returns some metrics" do
    # Create a test connection
    conn = conn(:get, "/metrics")

    # Invoke the plug
    conn = Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200

    # Assert contains at least 'http_requests_total' metric
    assert String.contains?(conn.resp_body, "http_requests_total")
  end

  test "responds 404 to not found" do
    # Create a test connection
    conn = conn(:get, "/any")

    # Invoke the plug
    conn = Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 404
  end

  test "start code does not crash" do
    {:error, {:already_started, _pid}} = Derivco.start(:normal, [])
  end
end
