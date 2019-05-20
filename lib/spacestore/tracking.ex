defmodule Spacestore.Tracking do
  @moduledoc """
  The Tracking context.
  """

  import Ecto.Query, warn: false
  alias Spacestore.Repo

  alias Spacestore.Tracking.StoreCoordinate

  @doc """
  Returns the list of store_coordinates.

  ## Examples

      iex> list_store_coordinates()
      [%StoreCoordinate{}, ...]

  """
  def list_store_coordinates do
    Repo.all(StoreCoordinate)
  end

  @doc """
  Gets a single store_coordinate.

  Raises `Ecto.NoResultsError` if the Store coordinate does not exist.

  ## Examples

      iex> get_store_coordinate!(123)
      %StoreCoordinate{}

      iex> get_store_coordinate!(456)
      ** (Ecto.NoResultsError)

  """
  def get_store_coordinate!(id), do: Repo.get!(StoreCoordinate, id)

  @doc """
  Creates a store_coordinate.

  ## Examples

      iex> create_store_coordinate(%{field: value})
      {:ok, %StoreCoordinate{}}

      iex> create_store_coordinate(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_store_coordinate(attrs \\ %{}) do
    %StoreCoordinate{}
    |> StoreCoordinate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a store_coordinate.

  ## Examples

      iex> update_store_coordinate(store_coordinate, %{field: new_value})
      {:ok, %StoreCoordinate{}}

      iex> update_store_coordinate(store_coordinate, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_store_coordinate(%StoreCoordinate{} = store_coordinate, attrs) do
    store_coordinate
    |> StoreCoordinate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a StoreCoordinate.

  ## Examples

      iex> delete_store_coordinate(store_coordinate)
      {:ok, %StoreCoordinate{}}

      iex> delete_store_coordinate(store_coordinate)
      {:error, %Ecto.Changeset{}}

  """
  def delete_store_coordinate(%StoreCoordinate{} = store_coordinate) do
    Repo.delete(store_coordinate)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking store_coordinate changes.

  ## Examples

      iex> change_store_coordinate(store_coordinate)
      %Ecto.Changeset{source: %StoreCoordinate{}}

  """
  def change_store_coordinate(%StoreCoordinate{} = store_coordinate) do
    StoreCoordinate.changeset(store_coordinate, %{})
  end
end
