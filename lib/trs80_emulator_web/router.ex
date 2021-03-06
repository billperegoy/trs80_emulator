defmodule Trs80EmulatorWeb.Router do
  use Trs80EmulatorWeb, :router

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

  scope "/", Trs80EmulatorWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", Trs80EmulatorWeb do
    pipe_through :api

    get "/state", StateController, :index

    # FIXME - this should turn to a post
    # just making the Elm side simpler to start
    get "/reset", StateController, :reset
    get "/tick", StateController, :tick

    get "/login", LoginController, :login
  end

  # Other scopes may use custom stacks.
  # scope "/api", Trs80EmulatorWeb do
  #   pipe_through :api
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
      pipe_through :browser
      live_dashboard "/dashboard", metrics: Trs80EmulatorWeb.Telemetry
    end
  end
end
