defmodule Spacestore.Tracking.StoreCoordinate do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spacestore.Business.Store

  schema "store_coordinates" do
    field :latitude, :float
    field :longitude, :float
    
    belongs_to :store, Store

    timestamps()
  end

  @doc false
  def changeset(store_coordinate, attrs) do
    store_coordinate
    |> cast(attrs, [:latitude, :longitude, :store_id])
    |> validate_required([:latitude, :longitude, :store_id])
  end
end
