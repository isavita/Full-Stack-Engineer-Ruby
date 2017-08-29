defmodule MarvelComicsWeb.ComicsView do
  use MarvelComicsWeb, :view

  alias MarvelComics.Repo
  alias MarvelComics.Schema.Like

  require Ecto.Query

  def all_comics(%{"results" => results}) do
    comics_likes = fetch_likes(results)
    for comics <- results do
      like = comics_likes[comics["id"]] |> first_or_new()
      %{
        id: comics["id"],
        title: comics["title"],
        like: like,
        description: comics["description"],
        cover: cover(comics)
      }
    end
  end

  def cover(%{"thumbnail" => image}) do
    "#{image["path"]}.#{image["extension"]}"
  end

  def change_page(nil, _), do: 1
  def change_page(current_page, change) do
    page = change.(current_page)
    if page >= 1, do: page, else: 1
  end

  defp fetch_likes(all_comics) do
    ids = for %{"id" => id} <- all_comics, not is_nil(id), do: to_integer(id)

    Like
    |> Ecto.Query.where([like], like.likable_id in ^ids and like.likable_type == "comics")
    |> Repo.all
    |> Enum.group_by(&(&1.likable_id))
  end

  defp first_or_new(nil), do: %Like{}
  defp first_or_new([first | _]), do: first

  defp to_integer(comics_id) when is_integer(comics_id), do: comics_id
  defp to_integer(comics_id) when is_bitstring(comics_id) do
    {comics_id, _mod} = Integer.parse(comics_id)
    comics_id
  end
end
