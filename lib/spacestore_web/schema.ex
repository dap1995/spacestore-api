defmodule SpacestoreWeb.Schema do
  use Absinthe.Schema
  import_types __MODULE__.UserTypes
  import_types __MODULE__.StoreTypes

  alias SpacestoreWeb.UserResolver
  alias SpacestoreWeb.StoreResolver
  alias SpacestoreWeb.StoreAddressResolver
  alias SpacestoreWeb.StoreCoordinateResolver
  alias SpacestoreWeb.StoreImagesResolver

  query do
    field :users, list_of(:user) do
      resolve(&UserResolver.all/2)
    end

    field :user, :user do
      arg(:email, non_null(:string))
      resolve(&UserResolver.find/2)
    end

    field :stores, list_of(:store) do
      resolve(&StoreResolver.all/2)
    end

    field :store, :store do
      arg(:name, non_null(:string))
      resolve(&StoreResolver.find/2)
    end

    field :stores_by_distance, non_null(list_of(non_null(:store))) do
      arg :latitude, non_null(:float)
      arg :longitude, non_null(:float)
      arg :distance, :float, default_value: 10
      resolve &StoreResolver.stores_by_distance/2
    end

    mutation do
      field :create_user, type: :user do
        arg(:name, non_null(:string))
        arg(:email, non_null(:string))
        arg(:password, non_null(:string))
        resolve(&UserResolver.create/2)
      end

      field :login, type: :session do
        arg(:email, non_null(:string))
        arg(:password, non_null(:string))
        resolve(&UserResolver.login/2)
      end

      field :create_store, type: :store do
        arg(:name, non_null(:string))
        arg(:email, non_null(:string))
        arg(:description, non_null(:string))
        arg(:document, non_null(:string))
        resolve(&StoreResolver.create/2)
      end

      field :update_store, type: :store do
        arg(:id, non_null(:id))
        arg(:data, :update_store_data)
        resolve(&StoreResolver.update/2)
      end

      field :create_store_address, type: :store_address do
        arg(:cep, non_null(:string))
        arg(:city, non_null(:string))
        arg(:complement, non_null(:string))
        arg(:neighborhood, non_null(:string))
        arg(:number, non_null(:integer))
        arg(:street, non_null(:string))
        arg(:uf, non_null(:string))
        arg(:store_id, non_null(:id))
        
        resolve(&StoreAddressResolver.create/2)
      end

      field :update_store_address, type: :store_address do
        arg(:id, non_null(:id))
        arg(:data, :update_store_address_data)
        resolve(&StoreResolver.update_address/2)
      end

      field :update_store_coordinate, type: :store_coordinate do
        arg(:id, non_null(:id))
        arg(:data, :update_store_coordinate_data)
        resolve(&StoreResolver.update_coordinate/2)
      end

      field :update_store_coordinate, type: :store_coordinate do
        arg(:id, non_null(:id))
        arg(:sequence, non_null(:integer))
        arg(:data, :update_store_image_data)
        resolve(&StoreResolver.update_store_images/2)
      end

      field :create_store_coordinate, type: :store_coordinate do
        arg(:latitude, non_null(:float))
        arg(:longitude, non_null(:float))
        arg(:store_id, non_null(:id))
        
        resolve(&StoreCoordinateResolver.create/2)
      end

      field :create_store_image, type: :store_images do
        arg(:url, non_null(:string))
        arg(:sequence, non_null(:integer))
        arg(:store_id, non_null(:id))
        
        resolve(&StoreImagesResolver.create/2)
      end

      field :sign_out, type: :user do
        resolve(&UserResolver.logout/2)
      end
    end
  end
end