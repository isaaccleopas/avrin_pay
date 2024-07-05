defmodule AvrinPay.Transaction.Commands.CreateInvoice do
  use Ash.Resource,
    domain: AvrinPay.Transaction

  attributes do
    attribute :invoice_id, :uuid, allow_nil?: false, primary_key?: true
    attribute :amount, :integer, allow_nil?: false, description: "The amount in kobo"
    attribute :title, :string, allow_nil?: false
    attribute :description, :string, allow_nil?: false
  end

  actions do
    default_accept [:invoice_id, :amount, :title, :description]
    defaults [:create, :read]

    create :dispatch do
      change fn changeset, _context ->
        Ash.Changeset.after_action(changeset, fn changeset, command ->
          case AvrinPay.Setup.Application.dispatch(command) do
            :ok -> {:ok, command}
            {:error, error} -> {:error, error}
          end

          {:ok, command}
        end)
      end
    end
  end
end
