defmodule SpacestoreWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation

  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)
  end
end