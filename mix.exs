defmodule GithubOauth.Mixfile do
  use Mix.Project

  def project do
    [app: :github_oauth,
     version: "0.1.1",
     elixir: "~> 1.0",
     deps: deps,
     description: description,
     package: package]
  end

  def application do
    [applications: [:logger]]
  end

  defp description do
    "simple github oauth library"
  end

  defp package do
    [files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
     contributors: ["lidashuang"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/lidashuang/github_oauth"}]
  end

  defp deps do
    [{:httpoison, "~> 0.6"},
    {:poison, "~> 1.3"}]
  end
end
