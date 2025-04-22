defmodule Fridge.SnacksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Fridge.Snacks` context.
  """

  import Fridge.Factory

  @doc """
  Generate a snack.
  """
  def snack_fixture(attrs \\ %{}) do
    user_id = Map.get(attrs, :user_id) || insert(:user).id
    food_id = Map.get(attrs, :food_id) || insert(:food).id
    
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
