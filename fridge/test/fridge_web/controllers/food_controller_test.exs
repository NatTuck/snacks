defmodule FridgeWeb.FoodControllerTest do
  use FridgeWeb.ConnCase

  alias Fridge.Foods.Food

  @create_attrs %{
    name: "some name",
    cals_per_serv: 42,
    serv_size: 42,
    serv_unit: "some serv_unit",
    car_per_serv: 42,
    fat_per_serv: 42,
    pro_per_serv: 42,
    fib_per_serv: 42
  }
  @update_attrs %{
    name: "some updated name",
    cals_per_serv: 43,
    serv_size: 43,
    serv_unit: "some updated serv_unit",
    car_per_serv: 43,
    fat_per_serv: 43,
    pro_per_serv: 43,
    fib_per_serv: 43
  }
  @invalid_attrs %{name: nil, cals_per_serv: nil, serv_size: nil, serv_unit: nil, car_per_serv: nil, fat_per_serv: nil, pro_per_serv: nil, fib_per_serv: nil}

  setup %{conn: conn} do
    user = insert(:user)
    {:ok, token, _claims} = Fridge.Auth.Guardian.encode_and_sign(user)
    
    conn = 
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "Bearer #{token}")
      
    {:ok, conn: conn, user: user}
  end

  describe "index" do
    test "lists all foods", %{conn: conn} do
      conn = get(conn, ~p"/api/v1/foods")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create food" do
    test "renders food when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/foods", food: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/v1/foods/#{id}")

      assert %{
               "id" => ^id,
               "cals_per_serv" => 42,
               "car_per_serv" => 42,
               "fat_per_serv" => 42,
               "fib_per_serv" => 42,
               "name" => "some name",
               "pro_per_serv" => 42,
               "serv_size" => 42,
               "serv_unit" => "some serv_unit"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/foods", food: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update food" do
    setup [:create_food]

    test "renders food when data is valid", %{conn: conn, food: %Food{id: id} = food} do
      conn = put(conn, ~p"/api/v1/foods/#{food}", food: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/v1/foods/#{id}")

      assert %{
               "id" => ^id,
               "cals_per_serv" => 43,
               "car_per_serv" => 43,
               "fat_per_serv" => 43,
               "fib_per_serv" => 43,
               "name" => "some updated name",
               "pro_per_serv" => 43,
               "serv_size" => 43,
               "serv_unit" => "some updated serv_unit"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, food: food} do
      conn = put(conn, ~p"/api/v1/foods/#{food}", food: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete food" do
    setup [:create_food]

    test "deletes chosen food", %{conn: conn, food: food} do
      conn = delete(conn, ~p"/api/v1/foods/#{food}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/v1/foods/#{food}")
      end
    end
  end

  defp create_food(_) do
    food = insert(:food)
    %{food: food}
  end
end
