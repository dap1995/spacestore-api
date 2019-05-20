defmodule Spacestore.Business do
  @moduledoc """
  The Business context.
  """

  import Ecto.Query, warn: false
  alias Spacestore.Repo

  alias Spacestore.Business.Store


  @query_by_distance """
  SELECT
    stores.id,
    stores.name,
    stores.description,
    stores.email,
    stores.document,
    stores.inserted_at,
    stores.updated_at,
    stores.owner_id,
    (
      6371 * acos (
        cos(radians(?))
        * cos(radians(store_coordinates.latitude))
        * cos(radians(store_coordinates.longitude) - radians(?))
        + sin (radians(?))
        * sin(radians(store_coordinates.latitude))
      )
    ) AS distance
  FROM stores left join store_coordinates
  ON stores.id = store_coordinates.store_id
  HAVING distance < ?
  ORDER BY distance;
  """

  @doc """
  Returns the list of stores with preloaded associations based on distance.

    Example:
      > Spacestore.Business.list_stores_by_distance(%{
          latitude: -26.4885497, longitude: -49.0769937
        }, [])

  """
  def list_stores_by_distance(coordinates, preload) do
    query_stores_by_distance(coordinates)
    |> load_stores
    |> Spacestore.Repo.preload(preload)
  end

  defp load_stores(raw_query_result) do
    Enum.map(
      raw_query_result.rows,
      &Spacestore.Repo.load(
        Spacestore.Business.Store, {raw_query_result.columns, &1}
      )
    )
  end

  defp query_stores_by_distance(
    %{ latitude: latitude, longitude: longitude, distance: distance_km }
  ) do
    Ecto.Adapters.SQL.query!(
      Spacestore.Repo,
      @query_by_distance,
      [latitude, longitude, latitude, distance_km]
    )
  end

  @doc """
  Returns the list of stores.

  ## Examples

      iex> list_stores()
      [%Store{}, ...]

  """
  def list_stores do
    result = Repo.all(Store)
      |> Repo.preload([:owner, :address, :coordinate])
    IO.inspect result
    result
  end

  @doc """
  Gets a single store.

  Raises `Ecto.NoResultsError` if the Store does not exist.

  ## Examples

      iex> get_store!(123)
      %Store{}

      iex> get_store!(456)
      ** (Ecto.NoResultsError)

  """
  def get_store!(id), do: Repo.get!(Store, id)

  def get_store(id), do: Repo.get(Store, id)

  def get_store_by_name(name), do: Repo.get_by(Store, name: name)

  @doc """
  Creates a store.

  ## Examples

      iex> create_store(%{field: value})
      {:ok, %Store{}}

      iex> create_store(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_store(attrs \\ %{}, current_user) do
    %Store{owner: current_user}
    |> Store.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a store.

  ## Examples

      iex> update_store(store, %{field: new_value})
      {:ok, %Store{}}

      iex> update_store(store, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_store(%Store{} = store, attrs) do
    store
    |> Store.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Store.

  ## Examples

      iex> delete_store(store)
      {:ok, %Store{}}

      iex> delete_store(store)
      {:error, %Ecto.Changeset{}}

  """
  def delete_store(%Store{} = store) do
    Repo.delete(store)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking store changes.

  ## Examples

      iex> change_store(store)
      %Ecto.Changeset{source: %Store{}}

  """
  def change_store(%Store{} = store) do
    Store.changeset(store, %{})
  end

  alias Spacestore.Business.StoreAddress

  @doc """
  Returns the list of store_addresses.

  ## Examples

      iex> list_store_addresses()
      [%StoreAddress{}, ...]

  """
  def list_store_addresses do
    Repo.all(StoreAddress)
  end

  @doc """
  Gets a single store_address.

  Raises `Ecto.NoResultsError` if the Store address does not exist.

  ## Examples

      iex> get_store_address!(123)
      %StoreAddress{}

      iex> get_store_address!(456)
      ** (Ecto.NoResultsError)

  """
  def get_store_address!(id), do: Repo.get!(StoreAddress, id)

  @doc """
  Creates a store_address.

  ## Examples

      iex> create_store_address(%{field: value})
      {:ok, %StoreAddress{}}

      iex> create_store_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_store_address(attrs \\ %{}) do
    %StoreAddress{}
    |> StoreAddress.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a store_address.

  ## Examples

      iex> update_store_address(store_address, %{field: new_value})
      {:ok, %StoreAddress{}}

      iex> update_store_address(store_address, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_store_address(%StoreAddress{} = store_address, attrs) do
    store_address
    |> StoreAddress.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a StoreAddress.

  ## Examples

      iex> delete_store_address(store_address)
      {:ok, %StoreAddress{}}

      iex> delete_store_address(store_address)
      {:error, %Ecto.Changeset{}}

  """
  def delete_store_address(%StoreAddress{} = store_address) do
    Repo.delete(store_address)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking store_address changes.

  ## Examples

      iex> change_store_address(store_address)
      %Ecto.Changeset{source: %StoreAddress{}}

  """
  def change_store_address(%StoreAddress{} = store_address) do
    StoreAddress.changeset(store_address, %{})
  end
end
