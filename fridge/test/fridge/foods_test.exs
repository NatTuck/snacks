defmodule Fridge.FoodsTest do
  use Fridge.DataCase

  alias Fridge.Foods

  describe "foods" do
    alias Fridge.Foods.Food

    import Fridge.FoodsFixtures

    @invalid_attrs %{name: nil, cals_per_serv: nil, serv_size: nil, serv_unit: nil, car_per_serv: nil, fat_per_serv: nil, pro_per_serv: nil, fib_per_serv: nil}

    test "list_foods/0 returns all foods" do
      food = food_fixture()
      assert Foods.list_foods() == [food]
    end

    test "get_food!/1 returns the food with given id" do
      food = food_fixture()
      assert Foods.get_food!(food.id) == food
    end

    test "create_food/1 with valid data creates a food" do
      valid_attrs = %{name: "some name", cals_per_serv: 42, serv_size: 42, serv_unit: "some serv_unit", car_per_serv: 42, fat_per_serv: 42, pro_per_serv: 42, fib_per_serv: 42}

      assert {:ok, %Food{} = food} = Foods.create_food(valid_attrs)
      assert food.name == "some name"
      assert food.cals_per_serv == 42
      assert food.serv_size == 42
      assert food.serv_unit == "some serv_unit"
      assert food.car_per_serv == 42
      assert food.fat_per_serv == 42
      assert food.pro_per_serv == 42
      assert food.fib_per_serv == 42
    end

    test "create_food/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Foods.create_food(@invalid_attrs)
    end

    test "update_food/2 with valid data updates the food" do
      food = food_fixture()
      update_attrs = %{name: "some updated name", cals_per_serv: 43, serv_size: 43, serv_unit: "some updated serv_unit", car_per_serv: 43, fat_per_serv: 43, pro_per_serv: 43, fib_per_serv: 43}

      assert {:ok, %Food{} = food} = Foods.update_food(food, update_attrs)
      assert food.name == "some updated name"
      assert food.cals_per_serv == 43
      assert food.serv_size == 43
      assert food.serv_unit == "some updated serv_unit"
      assert food.car_per_serv == 43
      assert food.fat_per_serv == 43
      assert food.pro_per_serv == 43
      assert food.fib_per_serv == 43
    end

    test "update_food/2 with invalid data returns error changeset" do
      food = food_fixture()
      assert {:error, %Ecto.Changeset{}} = Foods.update_food(food, @invalid_attrs)
      assert food == Foods.get_food!(food.id)
    end

    test "delete_food/1 deletes the food" do
      food = food_fixture()
      assert {:ok, %Food{}} = Foods.delete_food(food)
      assert_raise Ecto.NoResultsError, fn -> Foods.get_food!(food.id) end
    end

    test "change_food/1 returns a food changeset" do
      food = food_fixture()
      assert %Ecto.Changeset{} = Foods.change_food(food)
    end
  end
end
