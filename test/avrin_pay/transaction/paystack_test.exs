defmodule AvrinPay.Transaction.PaystackTest do
  alias AvrinPay.Setup.Application
  alias AvrinPay.Transaction.Events.PaystackPaymentInitializedV1
  use AvrinPay.DataCase

  import Commanded.Assertions.EventAssertions

  describe "Paystack" do
    test "GIVEN: a paystack initialize command is dispatched, WHEN: the command is executed, THEN: paystack payment is initialized" do
      {:ok, %{payment_id: payment_id} = _command} = AvrinPay.Transaction.paystack_initialize_payment("example@gmail.com", 50000, "www.example.com")

      assert_receive_event(Application, PaystackPaymentInitializedV1,
        fn event -> event.payment_id == payment_id end,
        fn event ->
          assert event.email == "example@gmail.com"
          assert event.amount == 50000
          assert event.callback_url == nil
        end
      )
    end
  end
end
