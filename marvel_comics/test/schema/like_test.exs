defmodule MarvelComics.Schema.LikeTest do
  use MarvelComics.DataCase

  alias MarvelComics.Schema.Like
  alias MarvelComics.Repo

  test "creates likes" do
    like = %{likable_id: 42, likable_type: "comics", liker_id: 24, liker_type: "user"}

    changeset = Like.changeset(%Like{}, like)
    {:ok, inserted_like} = Repo.insert(changeset)

    assert inserted_like.likable_id == like.likable_id
    assert inserted_like.likable_type == like.likable_type
    assert inserted_like.liker_id == like.liker_id
    assert inserted_like.liker_type == like.liker_type
  end

  test "returns an error if does not have all necessary attributes" do
    like = %{likable_id: 42}

    changeset = Like.changeset(%Like{}, like)
    {:error, reason} = Repo.insert(changeset)

    refute changeset.valid?
    assert {"can't be blank", _} = reason.errors[:likable_type]
  end
end
