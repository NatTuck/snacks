defmodule FridgeWeb.AuthControllerTest do
  use FridgeWeb.ConnCase

  alias Fridge.Users.User

  @create_attrs %{
    email: "test@example.com",
    password: "password123"
  }
  @invalid_attrs %{email: "invalid", password: "short"}
  @login_attrs %{
    email: "test@example.com",
    password: "password123"
  }
  @invalid_login_attrs %{
    email: "test@example.com",
    password: "wrongpassword"
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "register user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/auth/register", user: @create_attrs)
      assert %{"id" => id, "email" => "test@example.com", "token" => token} = json_response(conn, 201)["data"]
      assert is_binary(token)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/auth/register", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "login user" do
    setup [:create_user]

    test "renders user and token when credentials are valid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/auth/login", @login_attrs)
      assert %{"id" => id, "email" => "test@example.com", "token" => token} = json_response(conn, 200)["data"]
      assert is_binary(token)
    end

    test "renders errors when credentials are invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/auth/login", @invalid_login_attrs)
      assert json_response(conn, 401)["errors"] != %{}
    end

    test "renders errors when user doesn't exist", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/auth/login", %{email: "nonexistent@example.com", password: "password123"})
      assert json_response(conn, 401)["errors"] != %{}
    end
  end

  defp create_user(_) do
    # Create a user with known credentials for login tests
    user = insert(:user, email: "test@example.com", password_hash: Argon2.hash_pwd_salt("password123"))
    %{user: user}
  end
end
