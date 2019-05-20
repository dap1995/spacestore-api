defmodule Spacestore.Business.Store do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spacestore.Account.User

  schema "stores" do
    field :description, :string
    field :document, :string
    field :email, :string
    field :name, :string
    
    belongs_to :owner, User

    timestamps()
  end

  @doc false
  def changeset(store, attrs) do
    store
    |> cast(attrs, [:name, :description, :email, :document])
    |> validate_required([:name, :description, :email, :document])
  end
end
