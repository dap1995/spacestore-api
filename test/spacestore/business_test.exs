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

  describe "store_addresses" do
    alias Spacestore.Business.StoreAddress

    @valid_attrs %{cep: "some cep", city: "some city", complement: "some complement", neighborhood: "some neighborhood", number: 42, street: "some street", uf: "some uf"}
    @update_attrs %{cep: "some updated cep", city: "some updated city", complement: "some updated complement", neighborhood: "some updated neighborhood", number: 43, street: "some updated street", uf: "some updated uf"}
    @invalid_attrs %{cep: nil, city: nil, complement: nil, neighborhood: nil, number: nil, street: nil, uf: nil}

    def store_address_fixture(attrs \\ %{}) do
      {:ok, store_address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Business.create_store_address()

      store_address
    end

    test "list_store_addresses/0 returns all store_addresses" do
      store_address = store_address_fixture()
      assert Business.list_store_addresses() == [store_address]
    end

    test "get_store_address!/1 returns the store_address with given id" do
      store_address = store_address_fixture()
      assert Business.get_store_address!(store_address.id) == store_address
    end

    test "create_store_address/1 with valid data creates a store_address" do
      assert {:ok, %StoreAddress{} = store_address} = Business.create_store_address(@valid_attrs)
      assert store_address.cep == "some cep"
      assert store_address.city == "some city"
      assert store_address.complement == "some complement"
      assert store_address.neighborhood == "some neighborhood"
      assert store_address.number == 42
      assert store_address.street == "some street"
      assert store_address.uf == "some uf"
    end

    test "create_store_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Business.create_store_address(@invalid_attrs)
    end

    test "update_store_address/2 with valid data updates the store_address" do
      store_address = store_address_fixture()
      assert {:ok, %StoreAddress{} = store_address} = Business.update_store_address(store_address, @update_attrs)
      assert store_address.cep == "some updated cep"
      assert store_address.city == "some updated city"
      assert store_address.complement == "some updated complement"
      assert store_address.neighborhood == "some updated neighborhood"
      assert store_address.number == 43
      assert store_address.street == "some updated street"
      assert store_address.uf == "some updated uf"
    end

    test "update_store_address/2 with invalid data returns error changeset" do
      store_address = store_address_fixture()
      assert {:error, %Ecto.Changeset{}} = Business.update_store_address(store_address, @invalid_attrs)
      assert store_address == Business.get_store_address!(store_address.id)
    end

    test "delete_store_address/1 deletes the store_address" do
      store_address = store_address_fixture()
      assert {:ok, %StoreAddress{}} = Business.delete_store_address(store_address)
      assert_raise Ecto.NoResultsError, fn -> Business.get_store_address!(store_address.id) end
    end

    test "change_store_address/1 returns a store_address changeset" do
      store_address = store_address_fixture()
      assert %Ecto.Changeset{} = Business.change_store_address(store_address)
    end
  end

  describe "store_images" do
    alias Spacestore.Business.StoreImages

    @valid_attrs %{sequence: 42, url: "some url"}
    @update_attrs %{sequence: 43, url: "some updated url"}
    @invalid_attrs %{sequence: nil, url: nil}

    def store_images_fixture(attrs \\ %{}) do
      {:ok, store_images} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Business.create_store_images()

      store_images
    end

    test "list_store_images/0 returns all store_images" do
      store_images = store_images_fixture()
      assert Business.list_store_images() == [store_images]
    end

    test "get_store_images!/1 returns the store_images with given id" do
      store_images = store_images_fixture()
      assert Business.get_store_images!(store_images.id) == store_images
    end

    test "create_store_images/1 with valid data creates a store_images" do
      assert {:ok, %StoreImages{} = store_images} = Business.create_store_images(@valid_attrs)
      assert store_images.sequence == 42
      assert store_images.url == "some url"
    end

    test "create_store_images/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Business.create_store_images(@invalid_attrs)
    end

    test "update_store_images/2 with valid data updates the store_images" do
      store_images = store_images_fixture()
      assert {:ok, %StoreImages{} = store_images} = Business.update_store_images(store_images, @update_attrs)
      assert store_images.sequence == 43
      assert store_images.url == "some updated url"
    end

    test "update_store_images/2 with invalid data returns error changeset" do
      store_images = store_images_fixture()
      assert {:error, %Ecto.Changeset{}} = Business.update_store_images(store_images, @invalid_attrs)
      assert store_images == Business.get_store_images!(store_images.id)
    end

    test "delete_store_images/1 deletes the store_images" do
      store_images = store_images_fixture()
      assert {:ok, %StoreImages{}} = Business.delete_store_images(store_images)
      assert_raise Ecto.NoResultsError, fn -> Business.get_store_images!(store_images.id) end
    end

    test "change_store_images/1 returns a store_images changeset" do
      store_images = store_images_fixture()
      assert %Ecto.Changeset{} = Business.change_store_images(store_images)
    end
  end
end
