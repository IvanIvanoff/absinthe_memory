defmodule AbsintheMemoryWeb.Router do
  use AbsintheMemoryWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: AbsintheMemoryWeb.Schema

    forward "/", Absinthe.Plug, schema: AbsintheMemoryWeb.Schema
  end
end
