defmodule FridgeWeb.Router do
  use FridgeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {FridgeWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug :accepts, ["json"]
    plug FridgeWeb.Auth.Pipeline
  end

  scope "/", FridgeWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api/v1", FridgeWeb do
    pipe_through :api

    post "/auth/login", AuthController, :login
    post "/auth/register", AuthController, :register
  end

  # Protected API routes that require authentication
  scope "/api/v1", FridgeWeb do
    pipe_through [:api, :api_auth]
    
    resources "/users", UserController, except: [:new, :edit]
    resources "/foods", FoodController, except: [:new, :edit]
    resources "/snacks", SnackController, except: [:new, :edit]
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:fridge, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: FridgeWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
