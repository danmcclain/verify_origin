defmodule VerifyOrigin do
  @behaviour Plug
  import Plug.Conn
  @unprotected_methods ["GET", "HEAD"]

  def init(opts), do: opts

  def call(%{method: method} = conn, _opts) when method in @unprotected_methods, do: conn
  def call(conn, domains) do
    get_req_header(conn, "origin")
    |> verify_origin(domains)
    |> send_response(conn)
  end

  defp verify_origin(nil, _domains), do: :invalid
  defp verify_origin([], _domains), do: :invalid
  defp verify_origin([origin|_], domains) do
    if Enum.member?(domains, origin), do: :valid, else: :invalid
  end

  defp send_response(:valid, conn), do: conn
  defp send_response(:invalid, conn), do: send_resp(conn, :bad_request, "") |> halt
end
