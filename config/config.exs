import Config

config :avrin_pay,
  ecto_repos: [AvrinPay.Setup.Repo],
  generators: [timestamp_type: :utc_datetime]

config :avrin_pay, event_stores: [AvrinPay.Setup.EventStore]

config :paystack, secret_key: System.get_env("PAYSTACK_SECRET_KEY")

config :avrin_pay, ash_domains: [AvrinPay.Transaction]

config :avrin_pay, AvrinPay.Setup.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "avrin_pay_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

  config :avrin_pay, AvrinPay.Setup.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "avrin_pay_test#{System.get_env("MIX_TEST_PARTITION")}",
  schema: "event_store",
  hostname: "localhost",
  pool_size: 10

config :avrin_pay, consistency: :strong

import_config "#{config_env()}.exs"
