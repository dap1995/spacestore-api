defmodule Spacestore.Business.StoreAddress do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spacestore.Business.Store

  schema "store_addresses" do
    field :cep, :string
    field :city, :string
    field :complement, :string
    field :neighborhood, :string
    field :number, :integer
    field :street, :string
    field :uf, :string
    
    belongs_to :store, Store

    timestamps()
  end

  @doc false
  def changeset(store_address, attrs) do
    store_address
    |> cast(attrs, [:cep, :neighborhood, :city, :street, :uf, :number, :complement, :store_id])
    |> validate_required([:cep, :neighborhood, :city, :street, :uf, :number, :complement, :store_id])
    |> unique_constraint(:unique_store_constraint, name: :unique_store)
  end
end
