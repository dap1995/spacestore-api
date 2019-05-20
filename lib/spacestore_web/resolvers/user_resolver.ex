
defmodule SpacestoreWeb.UserResolver do
  alias Spacestore.Account
  alias SpacestoreWeb.ErrorHelpers

  def all(_args, _info) do
    {:ok, Account.list_users()}
  end

  def find(%{email: email}, _info) do
    case Account.get_user_by_email(email) do
      nil -> {:error, "User email #{email} not found!"}
      user -> {:ok, user}
    end
  end

  def create(args, _info) do
    case Account.create_user(args) do
      {:ok, user} ->
        {:ok, user}
      {:error, error} ->
        {:error, ErrorHelpers.error_from_changeset_to_string(error)}
      error ->
        {:error, "could not create user"}
    end
  end
end