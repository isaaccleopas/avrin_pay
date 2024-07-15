defmodule AvrinPay.Transaction.PaystackTest do
  alias AvrinPay.Setup.Application
  alias AvrinPay.Transaction.Events.PaystackPaymentInitializedV1
  use AvrinPay.DataCase

  import Commanded.Assertions.EventAssertions

  describe "Paystack" do
    test "GIVEN: a paystack initialize command is dispatched, WHEN: the command is executed, THEN: paystack payment is initialized" do
      {:ok, command} = AvrinPay.Transaction.initialize_paystack_payment("example@gmail.com", 50000, "www.example.com")

      assert_receive_event(Application, PaystackPaymentInitializedV1,
        fn event -> event.payment_id == command.payment_id end,
        fn event ->
          assert event.email == command.email
          assert event.amount == command.amount
          assert event.callback_url == command.callback_url
          assert event.paystack_authorization_url == command.paystack_authorization_url
        end
      )
    end
  end
end
