defmodule Shelters.Evacuations do
  @moduledoc """
  The Evacuations context.
  """

  import Ecto.Query, warn: false
  alias Shelters.Repo

  alias Shelters.Evacuations.Evacuation

  @doc """
  Returns the list of evacuations.

  ## Examples

      iex> list_evacuations()
      [%Evacuation{}, ...]

  """
  def list_evacuations do
    Repo.all(Evacuation)
  end

  @doc """
  Gets a single evacuation.

  Raises `Ecto.NoResultsError` if the Evacuation does not exist.

  ## Examples

      iex> get_evacuation!(123)
      %Evacuation{}

      iex> get_evacuation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_evacuation!(id), do: Repo.get!(Evacuation, id)

  @doc"""
  get_evacuation_by_city
  選択された指定区市町村にある避難場所のリストをデータベースから取得
  """
  def get_evacuation_by_city(city) do
    Evacuation
    |> where([e], e.city == ^city)
    |> Repo.all
  end

  @doc"""
  get_evacuation_by_address
  選択された住所にある避難場所のリストをデータベースから取得
  """
  def get_evacuation_by_address(address) do
    Evacuation
    |> where([e], e.address == ^address)
    |> Repo.all
  end



  @doc """
  Creates a evacuation.

  ## Examples

      iex> create_evacuation(%{field: value})
      {:ok, %Evacuation{}}

      iex> create_evacuation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_evacuation(attrs \\ %{}) do
    %Evacuation{}
    |> Evacuation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a evacuation.

  ## Examples

      iex> update_evacuation(evacuation, %{field: new_value})
      {:ok, %Evacuation{}}

      iex> update_evacuation(evacuation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_evacuation(%Evacuation{} = evacuation, attrs) do
    evacuation
    |> Evacuation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a evacuation.

  ## Examples

      iex> delete_evacuation(evacuation)
      {:ok, %Evacuation{}}

      iex> delete_evacuation(evacuation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_evacuation(%Evacuation{} = evacuation) do
    Repo.delete(evacuation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking evacuation changes.

  ## Examples

      iex> change_evacuation(evacuation)
      %Ecto.Changeset{data: %Evacuation{}}

  """
  def change_evacuation(%Evacuation{} = evacuation, attrs \\ %{}) do
    Evacuation.changeset(evacuation, attrs)
  end
end
