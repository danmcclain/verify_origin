defmodule VerifyOriginTest do
  use ExUnit.Case, async: true
  use Plug.Test
  doctest VerifyOrigin

  @opts VerifyOrigin.init(["http://example.com", "https://example.com"])

  test "allows get requests to pass through without origin header" do
    conn =
      conn(:get, "http://example.com/foo")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == false
  end

  test "prevents POST requests without valid origin header" do
    conn =
      conn(:post, "http://example.com/foo")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == true
    assert conn.status == 400

    conn =
      conn(:post, "http://example.com/foo")
      |> put_req_header("origin", "http://bad.com")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == true
    assert conn.status == 400
  end

  test "allows POST requests to pass through with valid origin header" do
    conn =
      conn(:post, "http://example.com/foo")
      |> put_req_header("origin", "http://example.com")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == false

    conn =
      conn(:post, "http://example.com/foo")
      |> put_req_header("origin", "https://example.com")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == false
  end

  test "prevents PUT requests without valid origin header" do
    conn =
      conn(:put, "http://example.com/foo")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == true
    assert conn.status == 400

    conn =
      conn(:put, "http://example.com/foo")
      |> put_req_header("origin", "http://bad.com")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == true
    assert conn.status == 400
  end

  test "allows PUT requests to pass through with valid origin header" do
    conn =
      conn(:put, "http://example.com/foo")
      |> put_req_header("origin", "http://example.com")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == false

    conn =
      conn(:put, "http://example.com/foo")
      |> put_req_header("origin", "https://example.com")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == false
  end

  test "prevents PATCH requests without valid origin header" do
    conn =
      conn(:patch, "http://example.com/foo")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == true
    assert conn.status == 400

    conn =
      conn(:patch, "http://example.com/foo")
      |> put_req_header("origin", "http://bad.com")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == true
    assert conn.status == 400
  end

  test "allows PATCH requests to pass through with valid origin header" do
    conn =
      conn(:patch, "http://example.com/foo")
      |> put_req_header("origin", "http://example.com")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == false

    conn =
      conn(:patch, "http://example.com/foo")
      |> put_req_header("origin", "https://example.com")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == false
  end

  test "prevents DELETE requests without valid origin header" do
    conn =
      conn(:delete, "http://example.com/foo")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == true
    assert conn.status == 400

    conn =
      conn(:delete, "http://example.com/foo")
      |> put_req_header("origin", "http://bad.com")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == true
    assert conn.status == 400
  end

  test "allows DELETE requests to pass through with valid origin header" do
    conn =
      conn(:delete, "http://example.com/foo")
      |> put_req_header("origin", "http://example.com")
      |> VerifyOrigin.call(@opts)

    assert conn.halted == false

    conn =
      conn(:delete, "http://example.com/foo")
      |> put_req_header("origin", "https://example.com")
      |> VerifyOrigin.call(@opts)
    assert conn.halted == false
  end
end
