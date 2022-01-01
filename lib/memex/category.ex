defmodule Category do
  use Ecto.Schema

  schema "categories" do
    field(:name, :string)
    many_to_many(:podcasts, Podcast, join_through: "podcasts_categories")
  end
end
