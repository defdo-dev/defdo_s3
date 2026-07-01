defmodule Defdo.S3.MixProject do
  use Mix.Project

  def project do
    [
      app: :defdo_s3,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: [
        "test.all": ["test --include integration"]
      ],
      docs: [
        main: "readme",
        extras: ["README.md", "CHANGELOG.md", "examples/mnist.livemd", "examples/upload.livemd"]
      ],
      package: [
        description: "Req plugin for S3 (defdo fork).",
        licenses: ["Apache-2.0"],
        organization: "defdo",
        links: %{
          "GitHub" => "https://github.com/defdo-dev/defdo_s3"
        }
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger, :xmerl]
    ]
  end

  def cli do
    [
      preferred_envs: [
        "test.all": :test,
        docs: :docs,
        "hex.publish": :docs
      ]
    ]
  end

  defp deps do
    [
      {:req, "~> 0.5.6 or ~> 0.6.0"},
      {:ex_doc, ">= 0.0.0", only: :docs}
    ]
  end
end
