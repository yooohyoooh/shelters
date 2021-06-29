defmodule Shelters.EvacuationsTest do
  use Shelters.DataCase

  alias Shelters.Evacuations

  describe "evacuations" do
    alias Shelters.Evacuations.Evacuation

    @valid_attrs %{address: "some address", city: "some city", code: "some code", lat: 120.5, lng: 120.5, name: "some name", prefecture: "some prefecture"}
    @update_attrs %{address: "some updated address", city: "some updated city", code: "some updated code", lat: 456.7, lng: 456.7, name: "some updated name", prefecture: "some updated prefecture"}
    @invalid_attrs %{address: nil, city: nil, code: nil, lat: nil, lng: nil, name: nil, prefecture: nil}

    def evacuation_fixture(attrs \\ %{}) do
      {:ok, evacuation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Evacuations.create_evacuation()

      evacuation
    end

    test "list_evacuations/0 returns all evacuations" do
      evacuation = evacuation_fixture()
      assert Evacuations.list_evacuations() == [evacuation]
    end

    test "get_evacuation!/1 returns the evacuation with given id" do
      evacuation = evacuation_fixture()
      assert Evacuations.get_evacuation!(evacuation.id) == evacuation
    end

    test "create_evacuation/1 with valid data creates a evacuation" do
      assert {:ok, %Evacuation{} = evacuation} = Evacuations.create_evacuation(@valid_attrs)
      assert evacuation.address == "some address"
      assert evacuation.city == "some city"
      assert evacuation.code == "some code"
      assert evacuation.lat == 120.5
      assert evacuation.lng == 120.5
      assert evacuation.name == "some name"
      assert evacuation.prefecture == "some prefecture"
    end

    test "create_evacuation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Evacuations.create_evacuation(@invalid_attrs)
    end

    test "update_evacuation/2 with valid data updates the evacuation" do
      evacuation = evacuation_fixture()
      assert {:ok, %Evacuation{} = evacuation} = Evacuations.update_evacuation(evacuation, @update_attrs)
      assert evacuation.address == "some updated address"
      assert evacuation.city == "some updated city"
      assert evacuation.code == "some updated code"
      assert evacuation.lat == 456.7
      assert evacuation.lng == 456.7
      assert evacuation.name == "some updated name"
      assert evacuation.prefecture == "some updated prefecture"
    end

    test "update_evacuation/2 with invalid data returns error changeset" do
      evacuation = evacuation_fixture()
      assert {:error, %Ecto.Changeset{}} = Evacuations.update_evacuation(evacuation, @invalid_attrs)
      assert evacuation == Evacuations.get_evacuation!(evacuation.id)
    end

    test "delete_evacuation/1 deletes the evacuation" do
      evacuation = evacuation_fixture()
      assert {:ok, %Evacuation{}} = Evacuations.delete_evacuation(evacuation)
      assert_raise Ecto.NoResultsError, fn -> Evacuations.get_evacuation!(evacuation.id) end
    end

    test "change_evacuation/1 returns a evacuation changeset" do
      evacuation = evacuation_fixture()
      assert %Ecto.Changeset{} = Evacuations.change_evacuation(evacuation)
    end
  end
end
