import Config

config :plug, init_mode: :runtime
config :logger, level: :debug

config :e, E.Mailer, adapter: Bamboo.LocalAdapter
