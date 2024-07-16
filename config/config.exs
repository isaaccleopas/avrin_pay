# import Config

# config :avrin_pay, ecto_repos: [AvrinPay.Setup.Repo]
# config :avrin_pay, event_stores: [AvrinPay.Setup.EventStore]

# config :paystack, secret_key: System.get_env("PAYSTACK_SECRET_KEY")

# config :avrin_pay, ash_domains: [AvrinPay.Transaction]

# config :avrin_pay, mock_api_call?: System.get_env("MOCK_API_CALL") == "true"

# config :avrin_pay, consistency: :strong

# # Database configurations
# config :avrin_pay, AvrinPay.Setup.Repo,
#   username: "postgres",
#   password: "postgres",
#   hostname: "localhost",
#   database: "avrin_pay_test",
#   pool: Ecto.Adapters.SQL.Sandbox,
#   pool_size: 10

# config :avrin_pay, AvrinPay.Setup.EventStore,
#   serializer: Commanded.Serialization.JsonSerializer,
#   username: "postgres",
#   password: "postgres",
#   database: "avrin_pay_test",
#   schema: "event_store",
#   hostname: "localhost",
#   pool_size: 10
