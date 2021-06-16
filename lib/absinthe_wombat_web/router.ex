defmodule AbsintheWombatWeb.Router do
  use AbsintheWombatWeb, :router

  pipeline :api do
    plug :accepts, ["json"]

    plug(Plug.Parsers,
      parsers: [:urlencoded, :multipart, :json],
      pass: ["*/*"],
      json_decoder: Phoenix.json_library()
    )
  end

  # scope "/api", AbsintheWombatWeb do
  #   pipe_through :api

  #   get "/users", UserController, :index
  #   post "/users", UserController, :create
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: AbsintheWombatWeb.Telemetry
    end
  end

  if Mix.env() == :dev do
    scope "/" do
      forward "/",
              Absinthe.Plug.GraphiQL,
              schema: Absinthe.WombatWeb.Schema,
              interface: :playground,
              socket: AbsintheWombatWeb.UserSocket
    end

    # scope "/graphiql" do
    #   forward "/",
    #           Absinthe.Plug.GraphiQL,
    #           schema: Absinthe.WombatWeb.Schema,
    #           interface: :playground
    # end

    # end of scope
  end

  # scope "/api" do
  #   pipe_through :api

  #   forward "/",
  #           Absinthe.Plug,
  #           schema: Absinthe.WombatWeb.Schema,
  #            socket: AbsintheWombatWeb.UserSocket
  # end
end
