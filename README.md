# AvrinPay

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `avrin_pay` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:avrin_pay, "~> 0.1.0"}
  ]
end
```

For now we go with this
```elixir
def deps do
  [
    {:avrin_pay, git: "https://github.com/isaaccleopas/avrin_pay", branch: "main"}
  ]
end
```

Configuration Set the following environment variables in your application's config.exs:

```elixir
config :paystack, secret_key: System.get_env("PAYSTACK_SECRET_KEY")

config :avrin_pay,
  ash_domains: [AvrinPay.Transaction],
  consistency: :strong
```

Configuration Set the following environment variables in your application's dev.exs and test.exs:

```elixir
# Database configurations
config :avrin_pay, AvrinPay.Setup.Repo,
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  hostname: System.get_env("DB_HOSTNAME"),
  database: System.get_env("DB_NAME"),
  pool_size: 10

config :avrin_pay, AvrinPay.Setup.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  username: System.get_env("EVENT_STORE_USERNAME"),
  password: System.get_env("EVENT_STORE_PASSWORD"),
  database: System.get_env("EVENT_STORE_DB_NAME"),
  schema: "event_store",
  hostname: System.get_env("EVENT_STORE_HOSTNAME"),
  pool_size: 10
```

A similar AvrinPay.Setup.Repo and AvrinPay.Setup.EventStore coniguration should be set in your runtime.exs


In your mix.exs file under
```elixir
defp aliases do
  setup: ["deps.get", "ecto.setup", "avrin_pay.setup", ....],
  "avrin_pay.setup": ["run -e 'Mix.Tasks.AvrinPay.Setup.run([])'"],
end
```

1. Function for initialiazing payment using paystack API endpoint for transaction.
```elixir
AvrinPay.Transaction.initialize_paystack_payment(email, amount, callback_url)
eg.
AvrinPay.Transaction.initialize_paystack_payment("avrin@example.com", 50000, "www.example.com")
```
Response
```elixir
  {:ok,
    Response: %Paystack.Response{
      success: true,
      message: "Authorization URL created",
      data: %{
        "access_code" => "toftb5xwll1ngve",
        "authorization_url" => "https://checkout.paystack.com/toftb5xwll1ngve",
        "reference" => "9dxuin3kki"
      },
      meta: nil,
      status_code: 200
  }}
```

Documentation can be generated with ExDoc and published on HexDocs. Once published, the docs can be found at https://hexdocs.pm/avrin_pay
