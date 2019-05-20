defmodule SpacestoreWeb.Router do
  use SpacestoreWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward("/graphql",  Absinthe.Plug, schema: SpacestoreWeb.Schema)
    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: SpacestoreWeb.Schema)
  end
end
