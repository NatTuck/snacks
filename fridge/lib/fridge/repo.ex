defmodule Fridge.Repo do
  use Ecto.Repo,
    otp_app: :fridge,
    adapter: Ecto.Adapters.SQLite3
end
