defmodule HackernewsApi.Router do
  use HackernewsApi.Web, :router

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

  scope "/", HackernewsApi do
    pipe_through :browser

    get "/", DefaultController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", HackernewsApi do
    pipe_through :api

    get "/top-stories",   StoriesController, :top_stories
    get "/active-stories", StoriesController, :active_stories
    get "/newest-stories", StoriesController, :newest_stories
    get "/best-stories",  StoriesController, :best_stories
    # get "/show-hn",       StoriesController, :show_hn
    get "/ask-hn",        StoriesController, :ask_hn

  end
end
