defmodule AbsintheWombat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Absinthe.Wombat.Repo.Store

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AbsintheWombatWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: AbsintheWombat.PubSub},
      # Start the Endpoint (http/https)
      AbsintheWombatWeb.Endpoint
      # Start a worker by calling: AbsintheWombat.Worker.start_link(arg)
      # {AbsintheWombat.Worker, arg}
    ]

    # initialize the store
    Store.init()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AbsintheWombat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AbsintheWombatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
