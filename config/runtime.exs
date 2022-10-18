import Config

if System.get_env("WEB") || System.get_env("RELEASE_NAME") do
  config :e, EWeb.Endpoint, server: true
end

port = String.to_integer(System.get_env("PORT") || "4000")

config :e, EWeb.Endpoint,
  http: [
    ip: {127, 0, 0, 1},
    port: port
  ]
