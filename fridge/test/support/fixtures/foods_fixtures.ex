defmodule Fridge.FoodsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Fridge.Foods` context.
  """

  @doc """
  Generate a food.
  """
  def food_fixture(attrs \\ %{}) do
    {:ok, food} =
      attrs
      |> Enum.into(%{
        cals_per_serv: 42,
        car_per_serv: 42,
        fat_per_serv: 42,
        fib_per_serv: 42,
        name: "some name",
        pro_per_serv: 42,
        serv_size: 42,
        serv_unit: "some serv_unit"
      })
      |> Fridge.Foods.create_food()

    food
  end
end
