defmodule FridgeWeb.SnackControllerTest do
  use FridgeWeb.ConnCase

  alias Fridge.Snacks.Snack

  setup do
    user = insert(:user)
    food = insert(:food)
    
    @create_attrs %{
      eaten_on: ~D[2025-04-16],
      user_id: user.id,
      food_id: food.id
    }
    @update_attrs %{
      eaten_on: ~D[2025-04-17]
    }
    
    %{user: user, food: food}
  end
  @invalid_attrs %{eaten_on: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all snacks", %{conn: conn} do
      conn = get(conn, ~p"/api/snacks")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create snack" do
    test "renders snack when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/snacks", snack: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/snacks/#{id}")

      assert %{
               "id" => ^id,
               "eaten_on" => "2025-04-16"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/snacks", snack: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update snack" do
    setup [:create_snack]

    test "renders snack when data is valid", %{conn: conn, snack: %Snack{id: id} = snack} do
      conn = put(conn, ~p"/api/snacks/#{snack}", snack: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/snacks/#{id}")

      assert %{
               "id" => ^id,
               "eaten_on" => "2025-04-17"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, snack: snack} do
      conn = put(conn, ~p"/api/snacks/#{snack}", snack: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete snack" do
    setup [:create_snack]

    test "deletes chosen snack", %{conn: conn, snack: snack} do
      conn = delete(conn, ~p"/api/snacks/#{snack}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/snacks/#{snack}")
      end
    end
  end

  defp create_snack(_) do
    snack = insert(:snack)
    %{snack: snack}
  end
end
