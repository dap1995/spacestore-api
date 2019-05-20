defmodule Spacestore.Repo.Migrations.CreateStores do
  use Ecto.Migration

  def change do
    create table(:stores) do
      add :name, :string
      add :description, :text
      add :email, :string
      add :document, :string
      add :owner_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:stores, [:owner_id])
  end
end
