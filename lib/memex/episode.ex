defmodule Episode do
  use Ecto.Schema

  schema "episodes" do
    field(:title, :string)
    field(:enclosure_url, :string)
    field(:subtitle, :string)
    field(:summary, :string)
    field(:url, :string)
    belongs_to(:podcast, Podcast)
  end
end
