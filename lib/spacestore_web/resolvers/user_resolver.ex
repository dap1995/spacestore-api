
defmodule SpacestoreWeb.UserResolver do
  alias Spacestore.Account

  def all(_args, _info) do
    {:ok, Account.list_users()}
  end

  def find(%{email: email}, _info) do
    case Account.get_user_by_email(email) do
      nil -> {:error, "User email #{email} not found!"}
      user -> {:ok, user}
    end
  end
end