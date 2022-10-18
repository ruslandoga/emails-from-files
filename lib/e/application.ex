defmodule E.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  @app :e
  @endpoint EWeb.Endpoit

  @impl true
  def start(_type, _args) do
    web_config = Application.fetch_env!(@app, @endpoint)

    children = [
      maybe_server(web_config)
    ]

    children = Enum.reject(children, &is_nil/1)
    opts = [strategy: :one_for_one, name: E.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp maybe_server(config) do
    if config[:server] do
      {Plug.Cowboy, scheme: :http, plug: @endpoint, options: Keyword.fetch!(config, :http)}
    end
  end
end
