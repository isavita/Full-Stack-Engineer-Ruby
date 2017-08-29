defmodule MarvelComicsWeb.LikeControllerTest do
  use MarvelComicsWeb.ConnCase, async: true

  alias MarvelComics.Schema.Like
  alias MarvelComics.Repo

  setup do
    like_params = %{like: %{likable_id: 42, likable_type: "comics", liker_id: 24, liker_type: "user"}}

    %{like_params: like_params}
  end

  describe "create/2" do
    test "Creates, and responds with a newly created like if attributes are valid", %{like_params: like_params} do
      response =
        build_conn()
        |> post(like_path(build_conn(), :create, like_params))
        |> json_response(200)

      assert response == %{"likable_id" => 42, "likable_type" => "comics"}
    end

    test "Returns an error and does not create a new like if attributes are invalid", %{like_params: like_params} do
      like_params = %{like: Map.delete(like_params[:like], :likable_type)}

      response =
        build_conn()
        |> post(like_path(build_conn(), :create, like_params))
        |> json_response(422)

      expected = %{"errors" => [%{"likable_type" => "can't be blank"}]}

      assert response == expected
    end
  end

  describe "remove/2" do
    test "Deletes like base on likable and liker", %{like_params: like_params} do
      like =
        Like.changeset(%Like{}, like_params[:like])
        |> Repo.insert!

      conn =
        build_conn()
        |> post(like_path(build_conn(), :remove, like_params))

      assert conn.status == 204
      assert Repo.get(Like, like.id) == nil
    end
  end

  describe "delete/2" do
    test "Deletes like and responds with 204", %{like_params: like_params} do
      like =
        Like.changeset(%Like{}, like_params[:like])
        |> Repo.insert!

      conn =
        build_conn()
        |> delete(like_path(build_conn(), :delete, like.id))

      assert conn.status == 204
      assert Repo.get(Like, like.id) == nil
    end
  end
end
