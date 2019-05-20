defmodule SpacestoreWeb.Schema do
  use Absinthe.Schema
  import_types __MODULE__.UserTypes
  import_types __MODULE__.StoreTypes

  alias SpacestoreWeb.UserResolver
  alias SpacestoreWeb.StoreResolver

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
    end
  end
end