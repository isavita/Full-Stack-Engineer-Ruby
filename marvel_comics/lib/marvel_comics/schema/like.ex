defmodule MarvelComics.Schema.Like do
  use Ecto.Schema

  import Ecto
  import Ecto.Changeset
  import Ecto.Query

  schema "likes" do
    field :likable_id, :integer
    field :likable_type, :string
    field :liker_id, :integer
    field :liker_type, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:likable_id, :likable_type, :liker_id, :liker_type])
    |> validate_required([:likable_id, :likable_type])
  end
end
