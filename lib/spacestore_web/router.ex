defmodule SpacestoreWeb.Router do
  use SpacestoreWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SpacestoreWeb do
    pipe_through :api
  end
end
