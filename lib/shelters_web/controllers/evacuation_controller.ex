defmodule SheltersWeb.EvacuationController do
  use SheltersWeb, :controller

  alias Shelters.Evacuations
  alias Shelters.Evacuations.Evacuation

  def index(conn, _params) do
    evacuations = Evacuations.list_evacuations()

    render(conn, "index.html", evacuations: evacuations)
  end


  def new(conn, _params) do
    changeset = Evacuations.change_evacuation(%Evacuation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"evacuation" => evacuation_params}) do
    case Evacuations.create_evacuation(evacuation_params) do
      {:ok, evacuation} ->
        conn
        |> put_flash(:info, "Evacuation created successfully.")
        |> redirect(to: Routes.evacuation_path(conn, :show, evacuation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    evacuation = Evacuations.get_evacuation!(id)
    render(conn, "show.html", evacuation: evacuation)
  end

  def edit(conn, %{"id" => id}) do
    evacuation = Evacuations.get_evacuation!(id)
    changeset = Evacuations.change_evacuation(evacuation)
    render(conn, "edit.html", evacuation: evacuation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "evacuation" => evacuation_params}) do
    evacuation = Evacuations.get_evacuation!(id)

    case Evacuations.update_evacuation(evacuation, evacuation_params) do
      {:ok, evacuation} ->
        conn
        |> put_flash(:info, "Evacuation updated successfully.")
        |> redirect(to: Routes.evacuation_path(conn, :show, evacuation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", evacuation: evacuation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    evacuation = Evacuations.get_evacuation!(id)
    {:ok, _evacuation} = Evacuations.delete_evacuation(evacuation)

    conn
    |> put_flash(:info, "Evacuation deleted successfully.")
    |> redirect(to: Routes.evacuation_path(conn, :index))
  end
end
