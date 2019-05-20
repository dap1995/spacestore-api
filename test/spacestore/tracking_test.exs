defmodule Spacestore.TrackingTest do
  use Spacestore.DataCase

  alias Spacestore.Tracking

  describe "store_coordinates" do
    alias Spacestore.Tracking.StoreCoordinate

    @valid_attrs %{latitude: 120.5, longitude: 120.5}
    @update_attrs %{latitude: 456.7, longitude: 456.7}
    @invalid_attrs %{latitude: nil, longitude: nil}

    def store_coordinate_fixture(attrs \\ %{}) do
      {:ok, store_coordinate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracking.create_store_coordinate()

      store_coordinate
    end

    test "list_store_coordinates/0 returns all store_coordinates" do
      store_coordinate = store_coordinate_fixture()
      assert Tracking.list_store_coordinates() == [store_coordinate]
    end

    test "get_store_coordinate!/1 returns the store_coordinate with given id" do
      store_coordinate = store_coordinate_fixture()
      assert Tracking.get_store_coordinate!(store_coordinate.id) == store_coordinate
    end

    test "create_store_coordinate/1 with valid data creates a store_coordinate" do
      assert {:ok, %StoreCoordinate{} = store_coordinate} = Tracking.create_store_coordinate(@valid_attrs)
      assert store_coordinate.latitude == 120.5
      assert store_coordinate.longitude == 120.5
    end

    test "create_store_coordinate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracking.create_store_coordinate(@invalid_attrs)
    end

    test "update_store_coordinate/2 with valid data updates the store_coordinate" do
      store_coordinate = store_coordinate_fixture()
      assert {:ok, %StoreCoordinate{} = store_coordinate} = Tracking.update_store_coordinate(store_coordinate, @update_attrs)
      assert store_coordinate.latitude == 456.7
      assert store_coordinate.longitude == 456.7
    end

    test "update_store_coordinate/2 with invalid data returns error changeset" do
      store_coordinate = store_coordinate_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracking.update_store_coordinate(store_coordinate, @invalid_attrs)
      assert store_coordinate == Tracking.get_store_coordinate!(store_coordinate.id)
    end

    test "delete_store_coordinate/1 deletes the store_coordinate" do
      store_coordinate = store_coordinate_fixture()
      assert {:ok, %StoreCoordinate{}} = Tracking.delete_store_coordinate(store_coordinate)
      assert_raise Ecto.NoResultsError, fn -> Tracking.get_store_coordinate!(store_coordinate.id) end
    end

    test "change_store_coordinate/1 returns a store_coordinate changeset" do
      store_coordinate = store_coordinate_fixture()
      assert %Ecto.Changeset{} = Tracking.change_store_coordinate(store_coordinate)
    end
  end
end
