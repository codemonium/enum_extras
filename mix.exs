defmodule EnumExtras.MixProject do
  use Mix.Project

  def project do
    [
      app: :enum_extras,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      source_url: "https://github.com/codemonium/enum_extras"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    This project consists of extra functions that apply to Elixir enumerations.
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{
        GitHub: "https://github.com/codemonium/enum_extras"
      }
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.24", only: :dev, runtime: false}
    ]
  end
end
