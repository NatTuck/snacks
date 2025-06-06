defmodule Fridge.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Fridge.Repo

  alias Fridge.Users.User
  
  @doc """
  Gets a user by email.
  
  Returns nil if the user does not exist.
  """
  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end
  
  @doc """
  Authenticates a user.
  
  Returns `{:ok, user}` if the user exists and the password is correct.
  Returns `{:error, :unauthorized}` if the user exists but the password is incorrect.
  Returns `{:error, :not_found}` if the user does not exist.
  """
  def authenticate_user(email, password) do
    user = get_user_by_email(email)
    
    cond do
      user && Argon2.verify_pass(password, user.password_hash) ->
        {:ok, user}
      user ->
        {:error, :unauthorized}
      true ->
        # Prevent timing attacks by simulating password check
        Argon2.no_user_verify()
        {:error, :not_found}
    end
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
