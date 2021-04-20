defmodule Mailer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    alias Mailer.Consumers.BookingConsumer

    consumer_group_opts = [
      # setting for the ConsumerGroup
      heartbeat_interval: 1_000,
      # this setting will be forwarded to the GenConsumer
      commit_interval: 1_000
    ]

    gen_consumer_impl = BookingConsumer
    consumer_group_name = "elixir_group"
    topic_names = ["messages"]

    children = [
      # Start the Ecto repository
      Mailer.Repo,
      # Start the Telemetry supervisor
      MailerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Mailer.PubSub},
      # Start the Endpoint (http/https)
      MailerWeb.Endpoint,
      # Start a worker by calling: Mailer.Worker.start_link(arg)
      # {Mailer.Worker, arg}
      supervisor(
        KafkaEx.ConsumerGroup,
        [gen_consumer_impl, consumer_group_name, topic_names, consumer_group_opts]
      )
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mailer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MailerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
