defmodule Spacestore.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :password_hash, :string
      add :is_verified, :boolean, default: false, null: false
      add :token, :text

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
