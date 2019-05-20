
defmodule SpacestoreWeb.StoreCoordinateResolver do
  alias Spacestore.Business
  alias Spacestore.Tracking
  alias SpacestoreWeb.ErrorHelpers

  def create(args,  %{context: %{current_user: current_user}}) do
    store = Business.get_store(args.store_id)
    cond do
      store == nil -> {:error, "Store not found"}
      store.owner_id == current_user.id -> create_store_coordinate(args, current_user)
      true -> {:error, "User doesn't have this resource associated"}
    end
  end

  def create(_args, _info) do
    {:error, "Not Authorized"}
  end

  defp create_store_coordinate(args, current_user) do
    case Tracking.create_store_coordinate(args) do
      {:ok, store_address} -> {:ok, store_address}
      {:error, error} ->
        {:error, ErrorHelpers.error_from_changeset_to_string(error)}
      error ->
        {:error, "Could not create address"}
    end
  end
end