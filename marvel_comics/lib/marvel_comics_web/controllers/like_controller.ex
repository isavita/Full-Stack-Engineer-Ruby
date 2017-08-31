defmodule MarvelComicsWeb.LikeController do
  use MarvelComicsWeb, :controller

  alias MarvelComics.Schema.Like
  alias MarvelComics.Repo

  def create(conn, %{"like" => like_params}) do
    changeset = Like.changeset(%Like{}, like_params)

    case Repo.insert(changeset) do
      {:ok, like} ->
        render conn, "like.json", like: like
      {:error, changeset} ->
        conn |> put_status(422) |> render("422.json", changeset)
    end
  end

  def remove(conn, %{"like" => like_params}) do
    where_params =
      for {k, v} <- like_params, into: %{}, do: {String.to_atom(k), v}

    like = Repo.get_by(Like, where_params)

    delete(conn, %{"id" => like.id})
  end

  def delete(conn, %{"id" => id}) do
    like = Repo.get!(Like, id)
    Repo.delete!(like)

    send_resp(conn, :no_content, "")
  end
end
