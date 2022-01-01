defmodule Podcast do
  use Ecto.Schema

  schema "podcasts" do
    field(:title, :string)
    field(:summary, :string)
    field(:description, :string)
    field(:subtitle, :string)
    many_to_many(:categories, Category, join_through: "podcasts_categories")
    has_many(:episodes, Episode)
  end
end
