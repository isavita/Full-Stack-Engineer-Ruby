# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :marvel_comics,
  ecto_repos: [MarvelComics.Repo]

# Configures the endpoint
config :marvel_comics, MarvelComicsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "K8afZxcrsx1U+kD2AZa24IcryGtRvE+Az7gH7eGYYC4SsY4UpXBmgp9KJC/GyOtR",
  render_errors: [view: MarvelComicsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MarvelComics.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
