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
config :avrin_pay,
  ash_domains: [AvrinPay.Transaction],
  paystack: [
    secret_key: System.get_env("PAYSTACK_SECRET_KEY"),
    mock_api_call?: System.get_env("MOCK_API_CALL") == "true"
  ],
  consistency: :strong

# Database configurations
config :avrin_pay, AvrinPay.Setup.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "avrin_pay_test",
  pool_size: 10

config :avrin_pay, AvrinPay.Setup.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "avrin_pay_test",
  schema: "event_store",
  hostname: "localhost",
  pool_size: 10
  ```

This is the sample of how the functions are to be used in another application.
1. Function for creating invoice using paystack API endpoint for invoice creation.
```elixir
AvrinPay.Transaction.create_invoice(amount, name, description)
eg.
AvrinPay.Transaction.create_invoice(50000, "Avrin Innovations", "Paymenet for School fee")
```
Response
```elixir
  {:ok,
    %{
      status: true,
      message: "Page created",
      data: %{
        name: "Avrin Innovations",
        description: "Paymenet for School fee",
        amount: 50000,
        integration: 1175909,
        domain: "test",
        slug: "nz4jhoa-74",
        currency: "NGN",
        type: "payment",
        collect_phone: false,
        active: true,
        published: true,
        migrate: false,
        id: 1563546,
        createdAt: "2024-07-05T14:47:05.494Z",
        updatedAt: "2024-07-05T14:47:05.494Z"
      }
    }
  }
```

2. Function for initialiazing payment using paystack API endpoint for transaction.
```elixir
AvrinPay.Transaction.paystack_initialize_payment(email, amount)
eg.
AvrinPay.Transaction.paystack_initialize_payment("example@gmail.com", 50000)
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
