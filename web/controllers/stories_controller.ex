defmodule HackernewsApi.StoriesController do
  use HackernewsApi.Web, :controller

  def top_stories(conn, _params) do
    json(conn, %{ hello: :world })
  end

end
