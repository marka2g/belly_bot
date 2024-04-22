defmodule BellyBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = Application.get_env(:libcluster, :topologies, [])
    
    children = [
      BellyBotWeb.Telemetry,
      BellyBot.Repo,
      {DNSCluster, query: Application.get_env(:belly_bot, :dns_cluster_query) || :ignore},
      {Cluster.Supervisor, [topologies, [name: BellyBot.ClusterSupervisor]]},
      {Phoenix.PubSub, name: BellyBot.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: BellyBot.Finch},
      # Start a worker by calling: BellyBot.Worker.start_link(arg)
      # {BellyBot.Worker, arg},
      # Start to serve requests, typically the last entry
      BellyBotWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BellyBot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BellyBotWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
