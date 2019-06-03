
defmodule SpacestoreWeb.StoreAddressResolver do
  alias Spacestore.Business
  alias SpacestoreWeb.ErrorHelpers

  def create(args,  %{context: %{current_user: current_user}}) do
    store = Business.get_store(args.store_id)
    cond do
      store == nil -> {:error, "Store not found"}
      store.owner_id == current_user.id -> create_store_address(args, current_user)
      true -> {:error, "User doesn't have this resource associated"}
    end
  end

  def create(_args, _info) do
    {:error, "Not Authorized"}
  end

  defp create_store_address(args, current_user) do
    case Business.create_store_address(args) do
      {:ok, store_address} ->
        {:ok, store_address}
      {:error, error} ->
        {:error, ErrorHelpers.error_from_changeset_to_string(error)}
      error ->
        {:error, "Could not create address"}
    end
  end

  def update(args, %{context: %{current_user: current_user}}) do
    try do
      store_address = Business.get_store_address!(args.id)
      store = Business.get_store!(store_address.store_id)
      cond do
        store.owner_id == current_user.id -> update_store_address(store_address, args.data)
        true -> {:error, "User doesn't have this resource associated"}
      end
    rescue
      e in Ecto.NoResultsError -> {:error, "Store or address not found"}
    end
  end

  defp update_store_address(store_address, args) do
    case Business.update_store_address(store_address, args) do
      {:ok, store_address} ->
        {:ok, store_address}
      {:error, error} ->
        {:error, ErrorHelpers.error_from_changeset_to_string(error)}
      error ->
        {:error, "Could not create address"}
    end
  end

  def delete(args, %{context: %{current_user: current_user}}) do
    try do
      store_address = Business.get_store_address!(args.id)
      store = Business.get_store!(store_address.store_id)
      cond do
        store.owner_id == current_user.id -> Business.delete_store_address(store_address)
        true -> {:error, "User doesn't have this resource associated"}
      end
    rescue
      e in Ecto.NoResultsError -> {:error, "Store or coordinate not found"}
    end
  end

  def delete(_args, _info) do
    {:error, "Not Authorized"}
  end
end