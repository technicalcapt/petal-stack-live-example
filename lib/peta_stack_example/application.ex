defmodule PetaStackExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PetaStackExample.Repo,
      # Start the Telemetry supervisor
      PetaStackExampleWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PetaStackExample.PubSub},
      # Start the Endpoint (http/https)
      PetaStackExampleWeb.Endpoint
      # Start a worker by calling: PetaStackExample.Worker.start_link(arg)
      # {PetaStackExample.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PetaStackExample.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PetaStackExampleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
