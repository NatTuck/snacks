defmodule FridgeWeb.FoodController do
  use FridgeWeb, :controller

  alias Fridge.Foods
  alias Fridge.Foods.Food

  action_fallback FridgeWeb.FallbackController

  def index(conn, _params) do
    foods = Foods.list_foods()
    render(conn, :index, foods: foods)
  end

  def create(conn, %{"food" => food_params}) do
    with {:ok, %Food{} = food} <- Foods.create_food(food_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/foods/#{food}")
      |> render(:show, food: food)
    end
  end

  def show(conn, %{"id" => id}) do
    food = Foods.get_food!(id)
    render(conn, :show, food: food)
  end

  def update(conn, %{"id" => id, "food" => food_params}) do
    food = Foods.get_food!(id)

    with {:ok, %Food{} = food} <- Foods.update_food(food, food_params) do
      render(conn, :show, food: food)
    end
  end

  def delete(conn, %{"id" => id}) do
    food = Foods.get_food!(id)

    with {:ok, %Food{}} <- Foods.delete_food(food) do
      send_resp(conn, :no_content, "")
    end
  end
end
