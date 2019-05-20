defmodule Spacestore.Repo.Migrations.CreateStoreCoordinates do
  use Ecto.Migration

  def change do
    create table(:store_coordinates) do
      add :latitude, :float
      add :longitude, :float
      add :store_id, references(:stores, on_delete: :nothing)

      timestamps()
    end

    create index(:store_coordinates, [:store_id])
  end
end
