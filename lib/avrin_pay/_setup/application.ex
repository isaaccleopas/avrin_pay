defmodule AvrinPay.Setup.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  use Commanded.Application,
    otp_app: :avrin_pay,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: AvrinPay.Setup.EventStore
    ]

  # router AvrinNotify.Notification.Sms

  @impl true
  def start(_type, _args) do
    children = [
      AvrinPay.Setup.Repo,
      # Register Application
      __MODULE__,
      AvrinPay.Transaction.Supervisor,
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AvrinPay.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
