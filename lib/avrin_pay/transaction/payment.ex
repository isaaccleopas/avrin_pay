defmodule AvrinPay.Transaction.Payment do
  use Ash.Resource, domain: AvrinPay.Transaction
  use Commanded.Commands.Router

  alias AvrinPay.Transaction.Events.PaystackPaymentInitializedV1
  alias AvrinPay.Transaction.Commands.InitializePaystackPayment

  dispatch(InitializePaystackPayment, to: __MODULE__, identity: :payment_id)

  attributes do
    attribute(:invoice_id, :uuid, primary_key?: true, allow_nil?: false, public?: true)
    attribute(:payment_id, :uuid, primary_key?: true, allow_nil?: false, public?: true)
  end

  def execute(_aggregate_state, %InitializePaystackPayment{} = command) do
    PaystackPaymentInitializedV1.create(%{
      payment_id: command.payment_id,
      amount: command.amount,
      email: command.email,
      callback_url: command.callback_url,
      paystack_response: command.paystack_response
    })
  end

  def apply(state, _event) do
    state
  end
end
