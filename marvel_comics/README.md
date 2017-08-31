# Marvel's Comics App
Elixir version of Streetbees' Full Stack Engineer Task

## Installation
1. Prerequisite
  1. Install Erlang (>= 19) and Elixir (>= 1.4) [guide here](https://gist.github.com/rubencaro/6a28138a40e629b06470)
  1. Install Phoenix (1.3) [guide here](https://hexdocs.pm/phoenix/installation.html)
  1. Install NodeJS [guide here](https://nodejs.org/en/download/package-manager/)
  1. Install Postgres [guide here](http://postgresguide.com/setup/install.html)
1. Requirement to run the project
  1. Set a Postgres user and password in (`./config/dev.exs`)
  1. Create and Migrate the database
  ```bash
    mix ecto.create
    mix ecto.migrate
  ```
  1. Create `.env` in the project directory which exports your Marvel API keys
  ```bash
    export MARVEL_API_PUBLIC_KEY="###"
    export MARVEL_API_PRIVATE_KEY="###"
  ```
  1. Load `.env` before to start the app
  ```bash
    source .env
  ```
  1. Start the app
  ```bash
    mix phx.server
  ```

## Check the [app on heroku](https://marvel-comics-dev.herokuapp.com/)
