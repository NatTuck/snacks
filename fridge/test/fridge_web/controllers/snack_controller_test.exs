defmodule FridgeWeb.SnackControllerTest do
  use FridgeWeb.ConnCase

  alias Fridge.Snacks.Snack

  @invalid_attrs %{eaten_on: nil}

  setup do
    user = insert(:user)
    food = insert(:food)
    
    create_attrs = %{
      eaten_on: ~D[2025-04-16],
      user_id: user.id,
      food_id: food.id
    }
    
    update_attrs = %{
      eaten_on: ~D[2025-04-17]
    }
    
    %{user: user, food: food, create_attrs: create_attrs, update_attrs: update_attrs}
  end

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
    test "lists all snacks", %{conn: conn} do
      conn = get(conn, ~p"/api/v1/snacks")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create snack" do
    test "renders snack when data is valid", %{conn: conn, create_attrs: create_attrs} do
      conn = post(conn, ~p"/api/v1/snacks", snack: create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/v1/snacks/#{id}")

      assert %{
               "id" => ^id,
               "eaten_on" => "2025-04-16"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/snacks", snack: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update snack" do
    setup [:create_snack]

    test "renders snack when data is valid", %{conn: conn, snack: %Snack{id: id} = snack, update_attrs: update_attrs} do
      conn = put(conn, ~p"/api/v1/snacks/#{snack}", snack: update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/v1/snacks/#{id}")

      assert %{
               "id" => ^id,
               "eaten_on" => "2025-04-17"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, snack: snack} do
      conn = put(conn, ~p"/api/v1/snacks/#{snack}", snack: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete snack" do
    setup [:create_snack]

    test "deletes chosen snack", %{conn: conn, snack: snack} do
      conn = delete(conn, ~p"/api/v1/snacks/#{snack}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/v1/snacks/#{snack}")
      end
    end
  end

  defp create_snack(_) do
    snack = insert(:snack)
    %{snack: snack}
  end
end
