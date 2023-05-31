defmodule Wordnik.MixProject do
  use Mix.Project

  def project do
    [
      app: :wordnik,
      version: "1.0.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "Wordnik",
      description: "Wordnik API Elixir client",
      package: [
        maintainers: ["Jeff Rose"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/jt-rose/wordnik"}
      ],
      source_url: "https://github.com/jt-rose/wordnik",
      docs: [
        # The main page in the docs
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:jason, "~> 1.4"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end
end
