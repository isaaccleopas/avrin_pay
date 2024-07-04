defmodule AvrinPay.Transaction do
  use Ash.Domain

  resources do
    resource AvrinPay.Transaction.Commands.PaystackInitializePayment do
      define :paystack_initialize_payment, action: :dispatch, args: [:amount, :email]
    end
    resource AvrinPay.Transaction.Events.PaystackPaymentInitializedV1
  end
end
