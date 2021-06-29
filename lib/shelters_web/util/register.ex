defmodule Register do
  @doc"""
  CSVファイルからデータを取得し、データベースに登録するモジュール
  """

  alias Shelters.Evacuations.Evacuation

  def main do
    "130001_evacuation_center.csv"
    |> read_file()
    |> insert_data()
  end
  def read_file(file_name) do
    #ファイルデータをdataに格納、レコードごとに分割してリスト化
    {_status, data} = File.read(file_name)
    data_list = String.split(data, "\r\n")

    #head：["取引先番号,取引先名称...""] tail：それ以降の各レコードが入ったリスト
    # head = hd(data_list)
    keys = [:name, :code, :prefecture, :city, :address, :lat, :lng]
    tail = tl(data_list)

    #headを分割してリスト化
    # keys = String.split(head,",")

    for i <- tail do
      data = String.split(i, ",")

      list =
        for j <- 0..(length(keys) - 1) do
          %{Enum.at(keys, j) => Enum.at(data, j)}
        end
      Enum.reduce(list, %{}, fn x, acc -> Map.merge(x, acc) end)
    end
  end

  def insert_data(data) do
    Enum.each(data, fn x ->
      Evacuation.changeset(%Evacuation{}, x)
      |> Shelters.Repo.insert()
    end)
  end
end
