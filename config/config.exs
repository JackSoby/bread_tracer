# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bread_tracer,
  ecto_repos: [BreadTracer.Repo]

# Configures the endpoint
config :bread_tracer, BreadTracerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FNtUVMqvh29RQXN2pJZr6/u8dNq7JT0oo53PANMfz67UgB0Jf2JzH2zaP8KzU2LH",
  render_errors: [view: BreadTracerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BreadTracer.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :bread_tracer, BreadTracer.Auth.Guardian,
  issuer: "bread_tracer",
  # put the result of the mix command above here
  secret_key: "MhPWQtDhqD7KSWdrEy0ngyhwHDA45+oUvstdmPv8g2c2NNxvmFY0jzNRMf1vDXBt"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
