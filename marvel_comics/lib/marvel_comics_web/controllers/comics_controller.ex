defmodule MarvelComicsWeb.ComicsController do
  use MarvelComicsWeb, :controller

  import MarvelComicsWeb.Controllers.ComicsSearchHelpers

  @marvel_url "http://gateway.marvel.com/v1/public"

  def index(conn, %{"character_ids" => character_ids} = params) when bit_size(character_ids) > 0 do
    page = to_page(params["page"])
    url = "#{@marvel_url}/comics?characters=#{character_ids}&#{auth_token()}&#{with_issues()}&#{ordered()}&#{pagination(page)}"
    %{"data" => data} = fetch_comics(url)

    render conn, "index.html", data: data, page: page, character_ids: character_ids
  end
  def index(conn, params) do
    page = to_page(params["page"])
    url = "#{@marvel_url}/comics?#{auth_token()}&#{with_issues()}&#{ordered()}&#{pagination(page)}"
    %{"data" => data} = fetch_comics(url)

    render conn, "index.html", data: data, page: page, character_ids: nil
  end

  def search(conn, %{"search" => %{"query" => q}} = params) when bit_size(q) == 0, do: index(conn, params)
  def search(conn, %{"search" => %{"query" => query}} = params) do
    query = URI.encode(query)
    character_url = "#{@marvel_url}/characters?name=#{query}&#{auth_token()}"
    character_ids =
      fetch_comics(character_url)
      |> extract_character_ids()
      |> Enum.join(",")

    if character_ids != "" do
      index(conn, Map.put(params, "character_ids", character_ids))
    else
      render conn, "no_results.html"
    end
  end

  defp extract_character_ids(%{"data" => %{"results" => results}}) do
    Enum.map(results, fn %{"id" => id} -> id end)
  end
end
