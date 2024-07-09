defmodule AvrinPay.Transaction.Events.InvoiceCreatedV1 do
  use Ash.Resource, domain: AvrinPay.Transaction

  @derive {Jason.Encoder, only: [:invoice_id, :amount, :name, :description]}
  attributes do
    attribute :invoice_id, :uuid, allow_nil?: false, primary_key?: true
    attribute :amount, :integer, allow_nil?: false, description: "The amount in kobo"
    attribute :name, :string, allow_nil?: false
    attribute :description, :string, allow_nil?: false
  end

  actions do
    default_accept [:invoice_id, :amount, :name, :description]
    defaults [:create, :read]
  end

  code_interface do
    define :create
    define :read
  end
end
