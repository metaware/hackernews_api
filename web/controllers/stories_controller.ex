defmodule HackernewsApi.StoriesController do
  use HackernewsApi.Web, :controller

  def top_stories(conn, _params),    do: stories("", conn)
  def active_stories(conn, _params), do: stories("active", conn)
  def newest_stories(conn, _params), do: stories("newest", conn)
  def best_stories(conn, _params),   do: stories("best", conn)
  def show_hn(conn, _params),        do: stories("show", conn)
  def ask_hn(conn, _params),         do: stories("ask", conn)



  defp stories(path, conn) do
    case Hackernews.Frontpage.fetch do
      {:ok, response}  -> json(conn, response)
      {:error, reason} -> json(conn, reason)
    end
  end

end
