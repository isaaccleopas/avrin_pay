defmodule Mix.Tasks.AvrinPay.Setup do
  use Mix.Task
  alias AvrinPay.Setup.Repo
  alias AvrinPay.Setup.EventStore

  @shortdoc "Sets up the AvrinPay application"
  def run(_args) do
    Mix.Task.run("app.start", [])

    # Create and migrate the repo
    Mix.Task.run("ecto.create", ["-r", "AvrinPay.Setup.Repo"])
    Mix.Task.run("ecto.migrate", ["-r", "AvrinPay.Setup.Repo"])

    # Create and init the event store
    Mix.Task.run("event_store.create", ["-r", "AvrinPay.Setup.EventStore"])
    Mix.Task.run("event_store.init", ["-r", "AvrinPay.Setup.EventStore"])

    # Any other setup tasks
    IO.puts("AvrinPay setup completed.")
  end
end
