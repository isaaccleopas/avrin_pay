defmodule AvrinPay.Transaction.ExternalServices.PaystackInvoiceServiceManager do
  alias AvrinPay.Transaction.Events.InvoiceCreatedV1

  @base_url "https://api.paystack.co"
  @headers [
    Authorization: "Bearer #{Application.compile_env(:paystack, :secret_key)}",
    Accept: "Application/json"
  ]

  use Commanded.Event.Handler,
    application: AvrinPay.Setup.Application,
    name: __MODULE__

  def handle(%InvoiceCreatedV1{amount: amount, name: name, description: description}, _state) do
    {:ok, _response} = create_invoice(amount, name, description)
    :ok
  end

  def create_invoice(amount, name, description) do
    unless Application.get_env(:avrin_pay, :mock_api_call?) do
      url = @base_url <> "/page"

      body =
        %{
          name: name,
          amount: amount,
          description: description
        }
        |> Jason.encode!()

      case HTTPoison.post(url, body, @headers) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          IO.inspect(body)
          {:ok, body}

        {:error, %HTTPoison.Error{reason: reason}} ->
          {:error, "HTTPoison error: #{inspect(reason)}"}
      end
    else
      {:ok,
        %{
          status: true,
          message: "Page created",
          data: %{
            name: "Isaac",
            description: "Test Description",
            amount: 700000,
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
    end

  end
end
