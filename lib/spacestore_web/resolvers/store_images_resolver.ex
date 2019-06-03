
defmodule SpacestoreWeb.StoreImagesResolver do
  alias Spacestore.Business
  alias SpacestoreWeb.ErrorHelpers

  def create(args,  %{context: %{current_user: current_user}}) do
    store = Business.get_store(args.store_id)
    cond do
      store == nil -> {:error, "Store not found"}
      store.owner_id == current_user.id -> create_store_image(args, current_user)
      true -> {:error, "User doesn't have this resource associated"}
    end
  end

  def create(_args, _info) do
    {:error, "Not Authorized"}
  end

  defp create_store_image(args, current_user) do
    case Business.create_store_images(args) do
      {:ok, store_images} -> {:ok, store_images}
      {:error, error} ->
        {:error, ErrorHelpers.error_from_changeset_to_string(error)}
      error ->
        {:error, "Could not create image"}
    end
  end

  def update(args, %{context: %{current_user: current_user}}) do
    try do
      store_image = Business.get_store_images!(args.id)
      store = Business.get_store!(store_image.store_id)
      cond do
        store.owner_id == current_user.id -> update_store_image(store_image, args.data)
        true -> {:error, "User doesn't have this resource associated"}
      end
    rescue
      e in Ecto.NoResultsError -> {:error, "Store or image not found"}
    end
  end

  def update(_args, _info) do
    {:error, "Not Authorized"}
  end

  defp update_store_image(store_image, args) do
    case Business.update_store_images(store_image, args) do
      {:ok, store_image} ->
        {:ok, store_image}
      {:error, error} ->
        {:error, ErrorHelpers.error_from_changeset_to_string(error)}
      error ->
        {:error, "Could not update image"}
    end
  end

  def delete(args, %{context: %{current_user: current_user}}) do
    try do
      store_image = Business.get_store_images!(args.id)
      store = Business.get_store!(store_image.store_id)
      cond do
        store.owner_id == current_user.id -> Business.delete_store_images(store_image)
        true -> {:error, "User doesn't have this resource associated"}
      end
    rescue
      e in Ecto.NoResultsError -> {:error, "Store or image not found"}
    end
  end

  def delete(_args, _info) do
    {:error, "Not Authorized"}
  end
end