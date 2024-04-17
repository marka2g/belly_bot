defmodule BellyBot.Repo do
  use Ecto.Repo,
    otp_app: :belly_bot,
    adapter: Ecto.Adapters.Postgres
end
