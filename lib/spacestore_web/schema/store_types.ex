defmodule SpacestoreWeb.Schema.StoreTypes do
  use Absinthe.Schema.Notation

  object :store do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)
    field(:document, :string)
    field(:address, :store_address)
    field(:coordinate, :store_coordinate)
    field(:owner, :user)
  end

  object :store_coordinate do
    field :id, :id
    field :latitude, :string
    field :longitude, :string
  end

  object :store_address do
    field :id, :id
    field :cep, :string
    field :city, :string
    field :complement, :string
    field :neighborhood, :string
    field :number, :integer
    field :street, :string
    field :uf, :string
  end
end