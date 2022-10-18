defmodule EWeb.Endpoint do
  use Plug.Router, init_mode: Application.compile_env!(:plug, :init_mode)
  use Plug.ErrorHandler

  plug Plug.Logger, log: :debug
  plug :match
  plug Plug.Parsers, parsers: [:urlencoded, :multipart, :json], pass: ["*/*"], json_decoder: Jason
  plug :dispatch

  forward "/sent_emails", to: Bamboo.SentEmailViewerPlug

  match _ do
    send_resp(conn, 404, "Not found")
  end

  defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "Something went wrong")
  end
end
