
defmodule SpacestoreWeb.StoreResolver do
  alias Spacestore.Business
  alias SpacestoreWeb.ErrorHelpers

  def all(_args, %{context: %{current_user: _current_user}}) do
    {:ok, Business.list_stores()}
  end

  def all(_args, _info) do
    {:error, "Not Authorized"}
  end

  def find(%{name: name}, _info) do
    case Business.get_store_by_name(name) do
      nil -> {:error, "Store #{name} not found!"}
      store -> {:ok, store}
    end
  end

  def create(args,  %{context: %{current_user: current_user}}) do
    case Business.create_store(args, current_user) do
      {:ok, store} ->
        {:ok, store}
      {:error, error} ->
        {:error, ErrorHelpers.error_from_changeset_to_string(error)}
      error ->
        {:error, "could not create store"}
    end
  end

  def create(_args, _info) do
    {:error, "Not Authorized"}
  end
end