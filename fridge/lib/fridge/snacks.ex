defmodule Fridge.Snacks do
  @moduledoc """
  The Snacks context.
  """

  import Ecto.Query, warn: false
  alias Fridge.Repo

  alias Fridge.Snacks.Snack

  @doc """
  Returns the list of snacks.

  ## Examples

      iex> list_snacks()
      [%Snack{}, ...]

  """
  def list_snacks do
    Repo.all(Snack)
  end

  @doc """
  Returns the list of snacks for a given user eaten today, with food preloaded.

  ## Examples

      iex> list_snacks_for_user_today(user_id)
      [%Snack{food: %Food{}}, ...]

  """
  def list_snacks_for_user_today(user_id) do
    today = Date.utc_today()

    query =
      from s in Snack,
        where: s.user_id == ^user_id and s.eaten_on == ^today,
        # Preload the associated food
        preload: [:food]

    Repo.all(query)
  end

  @doc """
  Gets a single snack.

  Raises `Ecto.NoResultsError` if the Snack does not exist.

  ## Examples

      iex> get_snack!(123)
      %Snack{}

      iex> get_snack!(456)
      ** (Ecto.NoResultsError)

  """
  def get_snack!(id), do: Repo.get!(Snack, id)

  @doc """
  Creates a snack.

  ## Examples

      iex> create_snack(%{field: value})
      {:ok, %Snack{}}

      iex> create_snack(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_snack(attrs \\ %{}) do
    %Snack{}
    |> Snack.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a snack.

  ## Examples

      iex> update_snack(snack, %{field: new_value})
      {:ok, %Snack{}}

      iex> update_snack(snack, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_snack(%Snack{} = snack, attrs) do
    snack
    |> Snack.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a snack.

  ## Examples

      iex> delete_snack(snack)
      {:ok, %Snack{}}

      iex> delete_snack(snack)
      {:error, %Ecto.Changeset{}}

  """
  def delete_snack(%Snack{} = snack) do
    Repo.delete(snack)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking snack changes.

  ## Examples

      iex> change_snack(snack)
      %Ecto.Changeset{data: %Snack{}}

  """
  def change_snack(%Snack{} = snack, attrs \\ %{}) do
    Snack.changeset(snack, attrs)
  end
end
