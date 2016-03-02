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

  # Other scopes may use custom stacks.
  scope "/api", HackernewsApi do
    pipe_through :api

    get "/top-stories", StoriesController, :top_stories
  end
end
