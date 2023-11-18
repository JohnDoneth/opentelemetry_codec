defmodule OpenTelemetry.MixProject do
  use Mix.Project

  def project do
    [
      app: :opentelemetry_codec,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
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
      {:protox, "~> 1.6"},
      {:jason, "~> 1.2"},
      {:ex_doc, "~> 0.30", only: :dev, runtime: false}
    ]
  end
end
