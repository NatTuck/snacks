defmodule Fridge.SnacksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Fridge.Snacks` context.
  """

  import Fridge.UsersFixtures
  import Fridge.FoodsFixtures

  @doc """
  Generate a snack.
  """
  def snack_fixture(attrs \\ %{}) do
    # Create dependencies if not provided
    user_id = Map.get(attrs, :user_id) || user_fixture().id
    food_id = Map.get(attrs, :food_id) || food_fixture().id

    {:ok, snack} =
      attrs
      |> Enum.into(%{
        eaten_on: ~D[2025-04-16],
        user_id: user_id,
        food_id: food_id
      })
      |> Fridge.Snacks.create_snack()

    snack
  end
end
