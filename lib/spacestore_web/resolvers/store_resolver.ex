
defmodule SpacestoreWeb.StoreResolver do
  alias Spacestore.Business
  alias SpacestoreWeb.ErrorHelpers

  def all(_args, %{context: %{current_user: _current_user}}) do
    {:ok, Business.list_stores()}
  end

  def all(_args, _info) do
    {:error, "Not Authorized"}
  end

  def stores_by_distance(args, %{context: %{current_user: _current_user}}) do
    stores = Business.list_stores_by_distance(args, [:owner, :address, :coordinate, :images])
    {:ok, stores}
  end

  def stores_by_distance(_args, _info) do
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

  def update(args, %{context: %{current_user: current_user}}) do
    store = Business.get_store(args.id)
    cond do
      store == nil -> {:error, "Store not found"}
      store.owner_id == current_user.id -> update_store(store, args)
      true -> {:error, "User doesn't have this resource associated"}
    end
  end

  def update_store(store, args) do
    case Business.update_store(store, args.data) do
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

  def delete(args, %{context: %{current_user: current_user}}) do
    try do
      store = Business.get_store!(args.id)
      cond do
        store.owner_id == current_user.id -> Business.delete_store(store)
        true -> {:error, "User doesn't have this resource associated"}
      end
    rescue
      e in Ecto.NoResultsError -> {:error, "Store not found"}
    end
  end

  def delete(_args, _info) do
    {:error, "Not Authorized"}
  end
end