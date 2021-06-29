defmodule Shelters.Repo.Migrations.CreateEvacuations do
  use Ecto.Migration

  def change do
    create table(:evacuations) do
      add :name, :string
      add :code, :string
      add :prefecture, :string
      add :city, :string
      add :address, :string
      add :lat, :float
      add :lng, :float

      timestamps()
    end

  end
end
