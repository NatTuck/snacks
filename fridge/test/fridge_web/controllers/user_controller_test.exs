defmodule FridgeWeb.UserControllerTest do
  use FridgeWeb.ConnCase

  alias Fridge.Users.User

  @create_attrs %{
    email: "user@example.com",
    password: "password123"
  }
  @update_attrs %{
    email: "updated@example.com",
    password: "newpassword123"
  }
  @invalid_attrs %{email: nil, password: nil}

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
    test "lists all users", %{conn: conn, user: existing_user} do
      conn = get(conn, ~p"/api/v1/users")
      users_data = json_response(conn, 200)["data"]
      assert length(users_data) >= 1
      
      # Verify the authenticated user is in the list
      assert Enum.any?(users_data, fn user -> 
        user["id"] == existing_user.id && user["email"] == existing_user.email
      end)
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/users", user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/v1/users/#{id}")

      assert %{
               "id" => ^id,
               "email" => "user@example.com"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/users", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, ~p"/api/v1/users/#{user}", user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/v1/users/#{id}")

      assert %{
               "id" => ^id,
               "email" => "updated@example.com"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, ~p"/api/v1/users/#{user}", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, ~p"/api/v1/users/#{user}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/v1/users/#{user}")
      end
    end
  end

  defp create_user(_) do
    user = insert(:user)
    %{user: user}
  end
end
