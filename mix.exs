defmodule AvrinPay.MixProject do
  use Mix.Project

  def project do
    [
      app: :avrin_pay,
      version: "0.1.0",
      elixir: "~> 1.17",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {AvrinPay.Setup.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:paystack, "~> 0.7.0"},
      {:commanded, "~> 1.4"},
      {:jason, "~> 1.3"},
      {:commanded_eventstore_adapter, "~> 1.4"},
      {:ash, "~> 3.0"},
      {:ash_postgres, "~> 2.0.0"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp aliases do
    [
      "avrin_pay.setup": ["deps.get", "ecto.setup", "event_store.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "event_store.setup": ["event_store.create", "event_store.init"],
      "event_store.reset": ["event_store.drop", "event_store.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "event_store.setup", "test", "event_store.drop"],
    ]
  end
end
