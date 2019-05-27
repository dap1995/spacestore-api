defmodule Spacestore.Business.StoreImages do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spacestore.Business.Store

  schema "store_images" do
    field :sequence, :integer
    field :url, :string
    belongs_to :store, Store

    timestamps()
  end

  @doc false
  def changeset(store_images, attrs) do
    store_images
    |> cast(attrs, [:url, :sequence, :store_id])
    |> validate_required([:url, :sequence, :store_id])
    |> unique_constraint(:unique_sequence_constraint, name: :unique_sequence_by_store)
  end
end
