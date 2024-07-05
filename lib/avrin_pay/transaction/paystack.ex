defmodule AvrinPay.Transaction.Paystack do
  use Ash.Resource, domain: AvrinPay.Transaction
  use Commanded.Commands.Router

  alias AvrinPay.Transaction.Events.PaystackPaymentInitializedV1
  alias AvrinPay.Transaction.Commands.PaystackInitializePayment

  dispatch PaystackInitializePayment, to: __MODULE__, identity: :payment_id


  attributes do
    attribute :payment_id, :uuid, primary_key?: true, allow_nil?: false, public?: true
  end

  def execute(_aggregate_state, %PaystackInitializePayment{} = command) do
    PaystackPaymentInitializedV1.create(%{payment_id: command.payment_id, amount: command.amount, email: command.email})
  end

  def apply(state, _event) do
    state
  end
end
