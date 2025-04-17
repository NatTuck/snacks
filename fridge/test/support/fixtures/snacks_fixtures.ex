defmodule Fridge.SnacksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Fridge.Snacks` context.
  """

  @doc """
  Generate a snack.
  """
  def snack_fixture(attrs \\ %{}) do
    {:ok, snack} =
      attrs
      |> Enum.into(%{
        eaten_on: ~D[2025-04-16]
      })
      |> Fridge.Snacks.create_snack()

    snack
  end
end
