defmodule ShakeNBake.MixProject do
  use Mix.Project

  def project do
    [
      app: :shake_n_bake,
      version: "0.1.0",
      elixir: "~> 1.6",
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {ShakeNBake, []}
    ]
  end

  defp deps do
    [
      {:credo, "~> 0.9.1", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      name: :logstash_json,
      maintainers: ["Tobias Ara Svensson"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/svetob/logstash-json"},
    ]
  end
end
