
defmodule SpacestoreWeb.UserResolver do
  alias Spacestore.Account
  alias SpacestoreWeb.ErrorHelpers

  def all(_args, %{context: %{current_user: _current_user}}) do
    {:ok, Account.list_users()}
  end

  def all(_args, _info) do
    {:error, "Not Authorized"}
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

  def login(%{email: email, password: password}, _info) do
    with {:ok, user} <- Account.login_with_email_pass(email, password),
         {:ok, jwt, _} <- Spacestore.Guardian.encode_and_sign(user),
         {:ok, _ } <- Spacestore.Account.store_token(user, jwt) do
      {:ok, %{token: jwt}}
    end
  end

  def logout(_args,  %{context: %{current_user: current_user, token: _token}}) do
    Account.store_token(current_user, nil)
    {:ok, current_user}
  end

  def logout(_args, _info) do
    {:error, "Please log in first!"}
  end
end