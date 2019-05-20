defmodule Spacestore.Repo do
  use Ecto.Repo,
    otp_app: :spacestore,
    adapter: Ecto.Adapters.MySQL
end
