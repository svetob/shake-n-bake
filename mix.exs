defmodule ShakeNBake.MixProject do
  use Mix.Project

  def project do
    [
      app: :shake_n_bake,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ShakeNBake, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 0.9.1", only: [:dev], runtime: false}
    ]
  end
end
