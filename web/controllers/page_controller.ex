defmodule HackernewsApi.PageController do
  use HackernewsApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
