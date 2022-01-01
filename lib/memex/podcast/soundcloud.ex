defmodule Soundcloud.Feed do
  use Tesla
  plug(Tesla.Middleware.BaseUrl, "https://feeds.soundcloud.com")

  def fetch(id: id) do
    {:ok, res} = get("/users/soundcloud:users:" <> id <> "/sounds.rss")
    res.body
  end

  def fetch(username: username) do
    id = Soundcloud.Stream.id(username)
    fetch(id: id)
  end
end

defmodule Soundcloud.Stream do
  use Tesla
  plug(Tesla.Middleware.BaseUrl, "https://soundcloud.com")

  def fetch(username) do
    get("/#{username}")
  end

  def id(username) do
    {:ok, res} = fetch(username)

    Floki.parse_document!(res.body)
    |> Floki.find("head > meta[property=\"al:ios:url\"")
    |> hd
    |> Floki.attribute("content")
    |> hd
    |> String.split(":")
    |> List.last()
  end
end
