defmodule Shelters.Repo do
  use Ecto.Repo,
    otp_app: :shelters,
    adapter: Ecto.Adapters.Postgres
end
