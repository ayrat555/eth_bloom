defmodule EthBloom.Mixfile do
  use Mix.Project

  def project do
    [
      app: :eth_bloom,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:keccakf1600, "~> 2.0.0", hex: :keccakf1600_orig},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false}
    ]
  end
end
