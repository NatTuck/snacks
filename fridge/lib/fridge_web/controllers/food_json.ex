defmodule FridgeWeb.FoodJSON do
  alias Fridge.Foods.Food

  @doc """
  Renders a list of foods.
  """
  def index(%{foods: foods}) do
    %{data: for(food <- foods, do: data(food))}
  end

  @doc """
  Renders a single food.
  """
  def show(%{food: food}) do
    %{data: data(food)}
  end

  defp data(%Food{} = food) do
    %{
      id: food.id,
      name: food.name,
      cals_per_serv: food.cals_per_serv,
      serv_size: food.serv_size,
      serv_unit: food.serv_unit,
      car_per_serv: food.car_per_serv,
      fat_per_serv: food.fat_per_serv,
      pro_per_serv: food.pro_per_serv,
      fib_per_serv: food.fib_per_serv
    }
  end
end
