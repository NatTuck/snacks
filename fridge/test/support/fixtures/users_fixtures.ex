defmodule Fridge.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Fridge.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        password_hash: "some password_hash"
      })
      |> Fridge.Users.create_user()

    user
  end
end
