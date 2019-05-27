defmodule Spacestore.Repo.Migrations.CreateStoreImages do
  use Ecto.Migration

  def change do
    create table(:store_images) do
      add :url, :string
      add :sequence, :integer
      add :store_id, references(:stores, on_delete: :nothing)

      timestamps()
    end

    create index(:store_images, [:store_id])
    create unique_index(:store_images, [:store_id, :sequence], name: :unique_sequence_by_store)
  end
end
