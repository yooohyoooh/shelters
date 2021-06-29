defmodule SheltersWeb.PageController do
  use SheltersWeb, :controller
  alias Shelters.Evacuations
  alias Shelters.Evacuations.Evacuation

  def index(conn, _params) do
    evacuations = Evacuations.list_evacuations()
    changeset = Evacuation.changeset(%Evacuation{}, %{})
    render(conn, "index.html", evacuations: evacuations, changeset: changeset, city: nil, address: nil, point: nil)
  end

  def index_by_city(conn, %{"evacuation" => evacuation}) do
    # IO.puts("**----------------")
    # IO.inspect(evacuation["city"])
    # IO.puts("----------------**")
    city = evacuation["city"]
    evacuations = Evacuations.get_evacuation_by_city(city)
    changeset = Evacuation.changeset(%Evacuation{}, %{})
    render(conn, "index.html", evacuations: evacuations, changeset: changeset, city: city,  address: nil, point: nil)
  end

  def index_by_address(conn, %{"evacuation" => evacuation}) do
    address = evacuation["address"]
    [evacuation_of_ad] = Evacuations.get_evacuation_by_address(address)
    city = evacuation_of_ad.city
    evacuations = Evacuations.get_evacuation_by_city(city)
    changeset = Evacuation.changeset(%Evacuation{}, %{})
    render(conn, "index.html", evacuations: evacuations, changeset: changeset, city: city, address: address, point: evacuation_of_ad)
  end
end
