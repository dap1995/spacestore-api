defmodule Spacestore.Business.Store do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spacestore.Account.User
  alias Spacestore.Business.StoreAddress
  alias Spacestore.Tracking.StoreCoordinate

  schema "stores" do
    field :description, :string
    field :document, :string
    field :email, :string
    field :name, :string
    
    belongs_to :owner, User
    has_one :address, StoreAddress
    has_one :coordinate, StoreCoordinate

    timestamps()
  end

  @doc false
  def changeset(store, attrs) do
    store
    |> cast(attrs, [:name, :description, :email, :document])
    |> validate_required([:name, :description, :email, :document])
  end
end
