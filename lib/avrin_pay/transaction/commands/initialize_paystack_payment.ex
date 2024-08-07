defmodule AvrinPay.Transaction.Commands.InitializePaystackPayment do
  use Ash.Resource, domain: AvrinPay.Transaction

  attributes do
    attribute :payment_id, :uuid, allow_nil?: false, primary_key?: true, default: &Ash.UUID.generate/0
    attribute :amount, :integer, allow_nil?: false, description: "The amount in kobo"
    attribute :email, :string, allow_nil?: false
    attribute :callback_url, :string, allow_nil?: true
    attribute :paystack_response, :map, allow_nil?: true
  end

  actions do
    default_accept [:payment_id, :amount, :email, :callback_url, :paystack_response]
    defaults [:create, :read]

    create :dispatch do
      change fn changeset, _context ->
        email = Ash.Changeset.get_argument_or_attribute(changeset, :email)
        amount = Ash.Changeset.get_argument_or_attribute(changeset, :amount)
        callback_url = Ash.Changeset.get_argument_or_attribute(changeset, :callback_url)

        case AvrinPay.Transaction.ExternalServices.PaystackServiceManager.initialize(email, amount, callback_url) do
          {:ok, paystack_response} ->
            # Convert the response struct to a map
            paystack_response_map = Map.from_struct(paystack_response)
            # Extract the authorization_url from the nested data map
            authorization_url = paystack_response_map.data["authorization_url"]

            # Create a new map with the authorization_url in the desired format
            formatted_response = %{authorization_url: authorization_url}

            # Update the changeset with the formatted response
            Ash.Changeset.change_attribute(changeset, :paystack_response, formatted_response)

          _ ->
            Ash.Changeset.add_error(changeset, "Paystack API Error")
        end
      end

      # After action to dispatch command
      change fn changeset, _context ->
        Ash.Changeset.after_action(changeset, fn changeset, command ->
          case AvrinPay.Setup.Application.dispatch(command) do
            :ok -> {:ok, command}
            {:error, error} -> {:error, error}
          end
        end)
      end
    end
  end
end
