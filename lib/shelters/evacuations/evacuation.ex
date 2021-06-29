defmodule Shelters.Evacuations.Evacuation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "evacuations" do
    field :address, :string
    field :city, :string
    field :code, :string
    field :lat, :float
    field :lng, :float
    field :name, :string
    field :prefecture, :string

    timestamps()
  end

  @doc false
  def changeset(evacuation, attrs) do
    evacuation
    |> cast(attrs, [:name, :code, :prefecture, :city, :address, :lat, :lng])
    |> validate_required([:name, :code, :prefecture, :city, :address, :lat, :lng])
  end
end
