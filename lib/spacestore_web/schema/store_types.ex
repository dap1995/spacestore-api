defmodule SpacestoreWeb.Schema.StoreTypes do
  use Absinthe.Schema.Notation

  object :store do
    field :id, :id
    field :name, :string
    field :email, :string
    field :document, :string
    field :address, :store_address
    field :coordinate, :store_coordinate
    field :owner, :user
    field :images, non_null(list_of(non_null(:store_images)))
  end

  object :store_coordinate do
    field :id, :id
    field :latitude, :float
    field :longitude, :float
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

  object :store_images do
    field :id, :id
    field :url, :string
    field :sequence, :integer
  end

  input_object :update_store_data do
    field :name, :string
    field :email, :string
    field :document, :string
  end

  input_object :update_store_address_data do
    field :cep, :string
    field :city, :string
    field :complement, :string
    field :neighborhood, :string
    field :number, :integer
    field :street, :string
    field :uf, :string
  end

  input_object :update_store_coordinate_data do
    field :latitude, :float
    field :longitude, :float
  end

  input_object :update_store_image_data do
    field :url, :string
  end

end