defmodule SpacestoreWeb.Schema.StoreTypes do
  use Absinthe.Schema.Notation

  object :store do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)
    field(:document, :string)
    field(:address, :address)
    field(:coordinate, :coordinate)
    field(:owner, :user)
  end

  object :coordinate do
    field :latitude, :string
    field :longitude, :string
  end

  object :address do
    field :cep, :string
    field :city, :string
    field :complement, :string
    field :neighborhood, :string
    field :number, :integer
    field :street, :string
    field :uf, :string
  end
end