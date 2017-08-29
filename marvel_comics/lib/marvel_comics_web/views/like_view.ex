defmodule MarvelComicsWeb.LikeView do
  use MarvelComicsWeb, :view

  def render("like.json", %{like: like}) do
    %{likable_id: like.likable_id, likable_type: like.likable_type}
  end

  def render("422.json", changeset) do
    errors = Enum.map(changeset.errors, fn {field, detail} ->
      %{
        "#{field}" => render_detail(detail)
      }
    end)

    %{errors: errors}
  end

  def render_detail({message, values}) do
    Enum.reduce values, message, fn {k, v}, acc ->
      String.replace(acc, "%{#{k}}", to_string(v))
    end
  end
  def render_detail(message), do: message
end
