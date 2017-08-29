defmodule MarvelComics.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :likable_id, :integer
      add :likable_type, :string
      add :liker_id, :integer
      add :liker_type, :string

      timestamps()
    end
  end
end
