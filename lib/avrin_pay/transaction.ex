defmodule AvrinPay.Transaction do
  use Ash.Domain

  resources do
    # Commands
    resource AvrinPay.Transaction.Commands.InitializePaystackPayment do
      define :initialize_paystack_payment, action: :dispatch, args: [:email, :amount, :callback_url]
    end

    # Events
    resource AvrinPay.Transaction.Events.PaystackPaymentInitializedV1

    # Aggregate
    resource AvrinPay.Transaction.Paystack
  end
end
