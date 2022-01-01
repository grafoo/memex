defmodule Memex.Repo.Migrations.CreatePodcasts do
  use Ecto.Migration

  def change do
    create table(:podcasts) do
      add(:title, :text)
      add(:summary, :text)
      add(:description, :text)
      add(:subtitle, :text)
    end

    create table(:categories) do
      add(:name, :text)
      add(:podcast_id, references(:podcasts))
    end

    create(unique_index(:categories, [:name]))

    create table(:podcasts_categories) do
      add(:podcast_id, references(:podcasts))
      add(:category_id, references(:categories))
    end

    create(unique_index(:podcasts_categories, [:podcast_id, :category_id]))

    create table(:episodes) do
      add(:title, :text)
      add(:enclosure_url, :text)
      add(:subtitle, :text)
      add(:summary, :text)
      add(:url, :text)
      add(:podcast_id, references(:podcasts))
    end
  end
end
