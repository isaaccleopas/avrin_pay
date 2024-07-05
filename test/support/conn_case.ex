defmodule AvrinPay.ConnCase do

  use ExUnit.CaseTemplate

  setup tags do
    AvrinPay.DataCase.setup_sandbox(tags)
  end
end
