require IEx

defmodule Hackernews.Frontpage do
  use HTTPoison.Base

  @domain "https://news.ycombinator.com/"

  def process_url(url) do
    @domain
  end

  def process_response_body(html) do
    Floki.find(html, "table.itemlist > tr") 
    |> Enum.take(90)
    |> Enum.chunk(3)
    |> Enum.map(&Hackernews.Frontpage.extract_story/1)
  end

  def fetch do
    Hackernews.Frontpage.start
    case Hackernews.Frontpage.get("") do
      {:ok, response}   -> {:ok, response.body}
      {:error, reason}  -> {:ok, "Something went wrong"}
    end
  end

  def extract_story(markup) do
    story_link = Floki.find(markup, "td.subtext > a[href^=item]") |> Floki.attribute("href") |> List.first
    user_link  = Floki.find(markup, "td.subtext > a[href^=user]") |> Floki.attribute("href") |> List.first

    user = %{
      username: Floki.find(markup, "td.subtext > a[href^=user]") |> Floki.text,
      link:     Enum.join([@domain, user_link])
    }

    %{
      user:       user,
      id:         Floki.find(markup, "td.subtext > span.age > a[href^=item]") |> Floki.attribute("href") |> List.first |> String.split("=") |> List.last |> String.to_integer,
      title:      Floki.find(markup, "td.title > a") |> Floki.text,
      link:       Floki.find(markup, "td.title > a") |> Floki.attribute("href") |> List.first,
      source:     Floki.find(markup, "td.title > span.sitebit") |> Floki.text |> String.strip,
      hn_link:    Enum.join([@domain, story_link]),
      score:      Floki.find(markup, "td.subtext > span.score") |> Floki.text,
      comments:   Floki.find(markup, "td.subtext > a[href^=item]") |> Floki.text,
      posted_ago: Floki.find(markup, "td.subtext > span.age") |> Floki.text
    }
  end

end