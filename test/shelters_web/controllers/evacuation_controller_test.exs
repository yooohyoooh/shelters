defmodule SheltersWeb.EvacuationControllerTest do
  use SheltersWeb.ConnCase

  alias Shelters.Evacuations

  @create_attrs %{address: "some address", city: "some city", code: "some code", lat: 120.5, lng: 120.5, name: "some name", prefecture: "some prefecture"}
  @update_attrs %{address: "some updated address", city: "some updated city", code: "some updated code", lat: 456.7, lng: 456.7, name: "some updated name", prefecture: "some updated prefecture"}
  @invalid_attrs %{address: nil, city: nil, code: nil, lat: nil, lng: nil, name: nil, prefecture: nil}

  def fixture(:evacuation) do
    {:ok, evacuation} = Evacuations.create_evacuation(@create_attrs)
    evacuation
  end

  describe "index" do
    test "lists all evacuations", %{conn: conn} do
      conn = get(conn, Routes.evacuation_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Evacuations"
    end
  end

  describe "new evacuation" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.evacuation_path(conn, :new))
      assert html_response(conn, 200) =~ "New Evacuation"
    end
  end

  describe "create evacuation" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.evacuation_path(conn, :create), evacuation: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.evacuation_path(conn, :show, id)

      conn = get(conn, Routes.evacuation_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Evacuation"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.evacuation_path(conn, :create), evacuation: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Evacuation"
    end
  end

  describe "edit evacuation" do
    setup [:create_evacuation]

    test "renders form for editing chosen evacuation", %{conn: conn, evacuation: evacuation} do
      conn = get(conn, Routes.evacuation_path(conn, :edit, evacuation))
      assert html_response(conn, 200) =~ "Edit Evacuation"
    end
  end

  describe "update evacuation" do
    setup [:create_evacuation]

    test "redirects when data is valid", %{conn: conn, evacuation: evacuation} do
      conn = put(conn, Routes.evacuation_path(conn, :update, evacuation), evacuation: @update_attrs)
      assert redirected_to(conn) == Routes.evacuation_path(conn, :show, evacuation)

      conn = get(conn, Routes.evacuation_path(conn, :show, evacuation))
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{conn: conn, evacuation: evacuation} do
      conn = put(conn, Routes.evacuation_path(conn, :update, evacuation), evacuation: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Evacuation"
    end
  end

  describe "delete evacuation" do
    setup [:create_evacuation]

    test "deletes chosen evacuation", %{conn: conn, evacuation: evacuation} do
      conn = delete(conn, Routes.evacuation_path(conn, :delete, evacuation))
      assert redirected_to(conn) == Routes.evacuation_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.evacuation_path(conn, :show, evacuation))
      end
    end
  end

  defp create_evacuation(_) do
    evacuation = fixture(:evacuation)
    %{evacuation: evacuation}
  end
end
