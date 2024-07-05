defmodule AvrinPay.Transaction.Events.PaystackPaymentInitializedV1 do
  use Ash.Resource, domain: AvrinPay.Transaction

  attributes do
    attribute :payment_id, :uuid, allow_nil?: false, primary_key?: true
    attribute :amount, :integer, allow_nil?: false, description: "The amount in kobo"
    attribute :email, :string, allow_nil?: false
  end

  actions do
    default_accept [:payment_id, :amount, :email]
    defaults [:create, :read]
  end

  code_interface do
    define :create
    define :read
  end
end
