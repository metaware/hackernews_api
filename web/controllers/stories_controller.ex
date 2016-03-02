defmodule HackernewsApi.StoriesController do
  use HackernewsApi.Web, :controller

  def top_stories(conn, _params) do
    case Hackernews.Frontpage.fetch do
      {:ok, response} ->
        json(conn, response)
      {:error, reason} ->
        json(conn, reason)
    end
  end

end
