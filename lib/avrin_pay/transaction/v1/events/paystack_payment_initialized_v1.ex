defmodule AvrinPay.Transaction.V1.Events.PaystackPaymentInitialized do
  use Ash.Resource, domain: AvrinPay.Transaction

  @derive {Jason.Encoder, only: [:payment_id, :amount, :email, :callback_url, :paystack_authorization_url, :paystack_response]}
  attributes do
    attribute :payment_id, :uuid, allow_nil?: false, primary_key?: true
    attribute :amount, :integer, allow_nil?: false, description: "The amount in kobo"
    attribute :email, :string, allow_nil?: false
    attribute :callback_url, :string, allow_nil?: true
    attribute :paystack_authorization_url, :string, allow_nil?: false
    attribute :paystack_response, :map, allow_nil?: false
  end

  actions do
    default_accept [:payment_id, :amount, :email, :callback_url, :paystack_authorization_url, :paystack_response]
    defaults [:create, :read]
  end

  code_interface do
    define :create
    define :read
  end
end
