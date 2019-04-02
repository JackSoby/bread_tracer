defmodule BreadTracerWeb.Router do
  use BreadTracerWeb, :router
  alias BreadTracer.Auth.Pipeline
  import Guardian.Plug.EnsureAuthenticated

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    plug(BreadTracerWeb.GraphQL.Context)
  end

  # Our pipeline implements "maybe" authenticated. We'll use the `:ensure_auth` below for when we need to make sure someone is logged in.
  pipeline :auth do
    plug(BreadTracer.Auth.Pipeline)
  end

  # We use ensure_auth to fail if there is no one logged in
  pipeline :ensure_auth do
    plug(Guardian.Plug.EnsureAuthenticated)
  end

  # Maybe logged in routes
  scope "/", BreadTracerWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index

    get "/login", SessionController, :new
    post "/login", SessionController, :login
    post "/logout", SessionController, :logout
  end

  # GraphQL API
  scope "/graphql" do
    pipe_through([:auth, :graphql])

    forward("/", Absinthe.Plug, schema: BreadTracerWeb.GraphQL.Schema)
  end

  # GraphiQL Endpoint
  scope "/graphiql" do
    pipe_through([:auth, :graphql])
    forward("/", Absinthe.Plug.GraphiQL, schema: BreadTracerWeb.GraphQL.Schema, json_codec: Jason)
  end

  # Definitely logged in scope
  scope "/", BreadTracerWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/secret", SessionController, :secret
  end

  # Other scopes may use custom stacks.
  # scope "/api", BreadTracerWeb do
  #   pipe_through :api
  # end
end
