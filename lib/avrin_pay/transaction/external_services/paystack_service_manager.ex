defmodule AvrinPay.Transaction.ExternalServices.PaystackServiceManager do
  def initialize(email, amount, callback_url) do
    unless Application.get_env(:avrin_pay, :mock_api_call?) do
      case Paystack.Transaction.initialize(%{email: email, amount: amount, callback_url: callback_url}) do
        {:ok, %Paystack.Response{} = response} -> {:ok, response}
        {:error, error} -> {:error, error}
      end
    else
      {:ok,
      %Paystack.Response{
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
    end
  end
end
