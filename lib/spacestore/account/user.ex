defmodule Spacestore.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spacestore.Business.Store

  schema "users" do
    field :email, :string
    field :is_verified, :boolean, default: false
    field :name, :string
    field(:password, :string, virtual: true)
    field :password_hash, :string
    field :token, :string

    has_many :stores, Store

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :is_verified, :token])
    |> validate_required([:name, :email, :password, :is_verified])
    |> validate_length(:password, min: 5, max: 20)
    |> unique_constraint(:email, downcase: true)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))
      _ ->
        changeset
    end
  end

  def store_token_changeset(user, params \\ %{}) do
    user
    |> cast(params, [:token])
  end
end
