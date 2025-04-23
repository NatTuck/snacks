defmodule FridgeWeb.AuthJSON do
  # Function now expects snacks in the assigns map
  def login(%{user: user, token: token, snacks: snacks}) do
    %{
      data: %{
        # Include user details (consider filtering what's sent)
        user: %{
          id: user.id,
          email: user.email
          # Add other user fields if needed, but avoid sending sensitive info like password_hash
        },
        token: token,
        # Include the list of snacks (with preloaded food)
        snacks: snacks_to_json(snacks)
      }
    }
  end

  # Helper to ensure food is rendered correctly if needed,
  # although default JSON encoding might be sufficient.
  # Adjust this if the default encoding isn't what you need.
  defp snacks_to_json(snacks) do
    Enum.map(snacks, fn snack ->
      %{
        id: snack.id,
        eaten_on: snack.eaten_on,
        user_id: snack.user_id,
        food_id: snack.food_id,
        inserted_at: snack.inserted_at,
        updated_at: snack.updated_at,
        # Explicitly include the preloaded food data
        food: food_to_json(snack.food)
      }
    end)
  end

  defp food_to_json(food) do
    # Select the fields you want to expose for the food item
    %{
      id: food.id,
      name: food.name,
      cals_per_serv: food.cals_per_serv,
      serv_size: food.serv_size,
      serv_unit: food.serv_unit,
      car_per_serv: food.car_per_serv,
      fat_per_serv: food.fat_per_serv,
      pro_per_serv: food.pro_per_serv,
      fib_per_serv: food.fib_per_serv,
      fdc_id: food.fdc_id
      # Add other fields if necessary
    }
  end
end
