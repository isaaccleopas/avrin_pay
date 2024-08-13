defmodule AvrinPay.Transaction.PaymentTest do
  alias AvrinPay.Setup.Application
  alias AvrinPay.Transaction.Events.PaystackPaymentInitializedV1
  use AvrinPay.DataCase

  import Commanded.Assertions.EventAssertions

  describe "Paystack" do
    test "GIVEN: a paystack initialize command is dispatched, WHEN: the command is executed, THEN: paystack payment is initialized" do
      {:ok, command} =
        AvrinPay.Transaction.initialize_paystack_payment(
          "example@gmail.com",
          50000,
          "www.example.com"
        )

      assert_receive_event(
        Application,
        PaystackPaymentInitializedV1,
        fn event -> event.payment_id == command.payment_id end,
        fn event ->
          assert event.email == command.email
          assert event.amount == command.amount
          assert event.callback_url == command.callback_url
          assert event.paystack_authorization_url == command.paystack_authorization_url

          # Assuming the event paystack_response is a map with string keys
          paystack_response = convert_data_map_to_string_keys(event.paystack_response)
          assert paystack_response == command.paystack_response
        end
      )
    end
  end

  defp convert_data_map_to_string_keys(paystack_response) do
    paystack_response
    |> Enum.map(fn
      {:data, value} ->
        value =
          value
          |> Enum.map(fn {key, value} -> {to_string(key), value} end)
          |> Enum.into(%{})

        {:data, value}

      {key, value} ->
        {key, value}
    end)
    |> Enum.into(%{})

    # paystack_response
    # |> Enum.map(fn {key, value} ->
    #   case key do
    #     :data ->
    #       # change keys to strings
    #       value =
    #         value
    #         |> Enum.map(fn {key, value} -> {to_string(key), value} end)
    #         |> Enum.into(%{})
    #       {key, value}
    #     _ ->
    #       {key, value}
    #   end
    # end)
    # |> Enum.into(%{})
  end
end
