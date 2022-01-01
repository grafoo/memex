import Config

config :memex, Memex.Repo,
  database: "memex",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :memex, ecto_repos: [Memex.Repo]

config :tesla, adapter: Tesla.Adapter.Hackney
