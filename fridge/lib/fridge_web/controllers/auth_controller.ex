defmodule FridgeWeb.AuthController do
  use FridgeWeb, :controller

  alias Fridge.Users
  alias Fridge.Auth.Guardian

  action_fallback FridgeWeb.FallbackController

  def login(conn, %{"email" => email, "password" => password}) do
    case Users.authenticate_user(email, password) do
      {:ok, user} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(user)
        conn
        |> put_status(:ok)
        |> render(:login, user: user, token: token)
      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> put_view(json: FridgeWeb.ErrorJSON)
        |> render(:"401")
    end
  end

  def register(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(user)
        conn
        |> put_status(:created)
        |> render(:login, user: user, token: token)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(json: FridgeWeb.ChangesetJSON)
        |> render(:error, changeset: changeset)
    end
  end
end
