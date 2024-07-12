# defmodule AvrinPay.Transaction.ExternalServices.PaystackServiceManager do
#   alias AvrinPay.Transaction.Events.PaystackPaymentInitializedV1

#   use Commanded.Event.Handler,
#     application: AvrinPay.Setup.Application,
#     name: __MODULE__

#   def handle(%PaystackPaymentInitializedV1{email: email, amount: amount}, _state) do
#     {:ok, _response} = initialize(email, amount)
#     :ok
#   end

#   def initialize(email, amount) do
#     unless Application.get_env(:avrin_pay, :mock_api_call?) do
#       case Paystack.Transaction.initialize(%{email: email, amount: amount}) do
#         {:ok, %Paystack.Response{} = response} -> {:ok, response}
#         {:error, error} -> {:error, error}
#       end
#     else
#       {:ok,
#       Response: %Paystack.Response{
#         success: true,
#         message: "Authorization URL created",
#         data: %{
#           "access_code" => "toftb5xwll1ngve",
#           "authorization_url" => "https://checkout.paystack.com/toftb5xwll1ngve",
#           "reference" => "9dxuin3kki"
#         },
#         meta: nil,
#         status_code: 200
#       }}
#     end
#   end
# end
