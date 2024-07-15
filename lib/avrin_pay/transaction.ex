defmodule AvrinPay.Transaction do
  use Ash.Domain

  resources do
    resource AvrinPay.Transaction.Commands.InitializePaystackPayment do
      define :paystack_initialize_payment, action: :dispatch, args: [:email, :amount, :callback_url]
    end
    resource AvrinPay.Transaction.Commands.CreateInvoice do
      define :create_invoice, action: :dispatch, args: [:amount, :name, :description]
    end
    resource AvrinPay.Transaction.Events.InvoiceCreatedV1
    resource AvrinPay.Transaction.Events.PaystackPaymentInitializedV1
    resource AvrinPay.Transaction.Paystack
  end
end
