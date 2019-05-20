defmodule Spacestore.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spacestore.Business.Store

  schema "users" do
    field :email, :string
    field :is_verified, :boolean, default: false
    field :name, :string
    field :password_hash, :string
    field :token, :string

    has_many :stores, Store

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash, :is_verified, :token])
    |> validate_required([:name, :email, :password_hash, :is_verified, :token])
  end
end
