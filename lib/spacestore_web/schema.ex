defmodule SpacestoreWeb.Schema do
  use Absinthe.Schema
  import_types __MODULE__.UserTypes

  alias SpacestoreWeb.UserResolver

  query do
    field :users, list_of(:user) do
      resolve(&UserResolver.all/2)
    end

    field :user, :user do
      arg(:email, non_null(:string))
      resolve(&UserResolver.find/2)
    end

    mutation do
      field :create_user, type: :user do
        arg(:name, non_null(:string))
        arg(:email, non_null(:string))
        arg(:password, non_null(:string))
        resolve(&UserResolver.create/2)
      end
    end
  end
end