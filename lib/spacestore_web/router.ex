defmodule SpacestoreWeb.Router do
  use SpacestoreWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    plug SpacestoreWeb.Context
  end

  scope "/" do
    pipe_through :api
    pipe_through :graphql

    forward("/graphql",  Absinthe.Plug, schema: SpacestoreWeb.Schema)
    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: SpacestoreWeb.Schema)
  end
end
