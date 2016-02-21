defmodule VerifyOrigin.Mixfile do
  use Mix.Project

  def project do
    [app: :verify_origin,
     version: "0.1.0",
     elixir: "~> 1.2",
     name: "VerifyOrigin",
     description: "A library for using Origin header checking to prevent CSRF",
     source_url: "https://github.com/danmcclain/verify_origin",
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:plug, "~> 1.0"}]
  end

  defp package do
    [
      contributors: ["Dan McClain"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/danmcclain/verify_origin",
        "Documentation" => "http://hexdocs.pm/verify_origin"
      }
    ]
  end
end
