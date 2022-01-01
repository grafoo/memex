defmodule Memex do
  @moduledoc """
  Expand your memory with the magic of Elixir.

  The concept behind this project is basically throwing any resource against it
  and `Memex` should be able to figure out how to handle and store this stuff in
  a meaningful and queryable way.
  """
  alias Memex.Repo

  @doc """
  Slurp stuff.

  ## Examples

      iex> Memex.slurp("https://soundcloud.com/podcast")
      %Podcast{
        __meta__: #Ecto.Schema.Metadata<:loaded, "podcasts">,
	...
      }

  """
  def slurp("https://soundcloud.com/" <> username) do
    feed = Soundcloud.Feed.fetch(username: username) |> Feedraptor.parse()

    podcast =
      Repo.insert!(%Podcast{
        title: feed.title,
        summary: feed.itunes_summary,
        description: feed.description,
        subtitle: feed.itunes_subtitle
      })
      |> Repo.preload([:categories, :episodes])

    podcast_changeset = Ecto.Changeset.change(podcast)

    for category_name <- feed.itunes_categories do
      category = get_or_create(Category, name: category_name)

      podcast_category_changeset =
        podcast_changeset |> Ecto.Changeset.put_assoc(:categories, [category])

      Repo.update!(podcast_category_changeset)
    end

    Enum.map(feed.entries, fn e ->
      episode =
        Ecto.build_assoc(podcast, :episodes, %Episode{
          title: e.title,
          enclosure_url: e.enclosure_url,
          subtitle: e.itunes_subtitle,
          summary: e.summary,
          url: e.url
        })

      Repo.insert!(episode)
    end)

    Repo.preload(Repo.get(Podcast, podcast.id), [:categories, :episodes])
  end

  defp get_or_create(queryable, clauses) do
    result = Repo.get_by(queryable, clauses)

    if result do
      result
    else
      Map.merge(queryable.__struct__, Map.new(clauses)) |> Repo.insert!()
    end
  end
end
