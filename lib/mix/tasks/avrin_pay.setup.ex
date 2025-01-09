defmodule Mix.Tasks.AvrinPay.Setup do
  use Mix.Task

  @shortdoc "Sets up the AvrinPay application"
  def run(_args) do
    Mix.Task.run("app.start", [])

    # Create and migrate the repo
    # Mix.Task.run("ecto.create", ["--repo", "AvrinPay.Setup.Repo"])
    # Mix.Task.run("ecto.migrate", ["--repo", "AvrinPay.Setup.Repo"])

    # # Create and init the event store
    # Mix.Task.run("event_store.create", ["--eventstore", "AvrinPay.Setup.EventStore"])
    # Mix.Task.run("event_store.init", ["--eventstore", "AvrinPay.Setup.EventStore"])

    # Any other setup tasks
    IO.puts("AvrinPay setup completed.")
  end
end
