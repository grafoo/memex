defmodule Memex.MixProject do
  use Mix.Project

  def project do
    [
      app: :memex,
      version: "0.2.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Memex",
      source_url: "https://github.com/grafoo/memex"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Memex.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:feedraptor, "~> 0.3.0"},
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.18"},
      {:floki, "~> 0.19.0"},
      {:ecto_sql, "~> 3.7"},
      {:postgrex, ">= 0.0.0"}
    ]
  end

  defp description() do
    "Expand your memory."
  end

  defp package() do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/grafoo/memex"}
    ]
  end
end
