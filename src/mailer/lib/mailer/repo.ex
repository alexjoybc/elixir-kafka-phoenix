defmodule Mailer.Repo do
  use Ecto.Repo,
    otp_app: :mailer,
    adapter: Ecto.Adapters.Postgres
end
