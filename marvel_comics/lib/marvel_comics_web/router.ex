defmodule MarvelComicsWeb.Router do
  use MarvelComicsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MarvelComicsWeb do
    pipe_through :browser # Use the default browser stack

    resources "/comics", ComicsController, only: [:index]
    post "/comics/search", ComicsController, :search

    # Point the landing page to be the comics index
    get "/", ComicsController, :index

    resources "/like", LikeController, only: [:create, :delete]
    post "/like/remove", LikeController, :remove
  end
end
