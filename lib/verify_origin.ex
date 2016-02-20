defmodule VerifyOrigin do
  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(%{method: "GET"} = conn, _opts), do: conn
  def call(conn, domains) do
    get_req_header(conn, "origin")
    |> verify_origin(domains)
    |> send_response(conn)
  end

  defp verify_origin(nil, domains), do: :invalid
  defp verify_origin([], domains), do: :invalid
  defp verify_origin([origin|_], domains) do
    if Enum.member?(domains, origin), do: :valid, else: :invalid
  end

  defp send_response(:valid, conn), do: conn
  defp send_response(:invalid, conn), do: send_resp(conn, :bad_request, "") |> halt
end
