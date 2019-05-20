defmodule Spacestore.BusinessTest do
  use Spacestore.DataCase

  alias Spacestore.Business

  describe "stores" do
    alias Spacestore.Business.Store

    @valid_attrs %{description: "some description", document: "some document", email: "some email", name: "some name"}
    @update_attrs %{description: "some updated description", document: "some updated document", email: "some updated email", name: "some updated name"}
    @invalid_attrs %{description: nil, document: nil, email: nil, name: nil}

    def store_fixture(attrs \\ %{}) do
      {:ok, store} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Business.create_store()

      store
    end

    test "list_stores/0 returns all stores" do
      store = store_fixture()
      assert Business.list_stores() == [store]
    end

    test "get_store!/1 returns the store with given id" do
      store = store_fixture()
      assert Business.get_store!(store.id) == store
    end

    test "create_store/1 with valid data creates a store" do
      assert {:ok, %Store{} = store} = Business.create_store(@valid_attrs)
      assert store.description == "some description"
      assert store.document == "some document"
      assert store.email == "some email"
      assert store.name == "some name"
    end

    test "create_store/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Business.create_store(@invalid_attrs)
    end

    test "update_store/2 with valid data updates the store" do
      store = store_fixture()
      assert {:ok, %Store{} = store} = Business.update_store(store, @update_attrs)
      assert store.description == "some updated description"
      assert store.document == "some updated document"
      assert store.email == "some updated email"
      assert store.name == "some updated name"
    end

    test "update_store/2 with invalid data returns error changeset" do
      store = store_fixture()
      assert {:error, %Ecto.Changeset{}} = Business.update_store(store, @invalid_attrs)
      assert store == Business.get_store!(store.id)
    end

    test "delete_store/1 deletes the store" do
      store = store_fixture()
      assert {:ok, %Store{}} = Business.delete_store(store)
      assert_raise Ecto.NoResultsError, fn -> Business.get_store!(store.id) end
    end

    test "change_store/1 returns a store changeset" do
      store = store_fixture()
      assert %Ecto.Changeset{} = Business.change_store(store)
    end
  end
end
