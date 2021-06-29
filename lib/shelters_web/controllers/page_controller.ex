defmodule SheltersWeb.PageController do
  use SheltersWeb, :controller
  alias Shelters.Evacuations
  alias Shelters.Evacuations.Evacuation

  def index(conn, _params) do
    evacuations = Evacuations.list_evacuations()
    changeset = Evacuation.changeset(%Evacuation{}, %{})
    render(conn, "index.html", evacuations: evacuations, changeset: changeset, city: nil)
  end

  def index_by_city(conn, %{"evacuation" => evacuation}) do
    # IO.puts("**----------------")
    # IO.inspect(evacuation["city"])
    # IO.puts("----------------**")
    city = evacuation["city"]
    evacuations = Evacuations.get_evacuation_by_city(city)
    changeset = Evacuation.changeset(%Evacuation{}, %{})
    render(conn, "index.html", evacuations: evacuations, changeset: changeset, city: city)
  end
end
