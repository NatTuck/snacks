defmodule FridgeWeb.AuthController do
  use FridgeWeb, :controller

  alias Fridge.Users
  alias Fridge.Auth.Guardian
  alias Fridge.Snacks # Alias the Snacks context
  import Date # Import Date for today's snacks

  action_fallback FridgeWeb.FallbackController

  def login(conn, %{"email" => email, "password" => password}) do
    case Users.authenticate_user(email, password) do
      {:ok, user} ->
        # Fetch today's snacks for the user
        snacks = Snacks.list_snacks_for_user_today(user.id)
        {:ok, token, _claims} = Guardian.encode_and_sign(user)

        conn
        |> put_status(:ok)
        # Pass user, token, and snacks to the view
        |> render(:login, user: user, token: token, snacks: snacks)

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
        # New users won't have snacks yet, so pass an empty list
        snacks = []
        {:ok, token, _claims} = Guardian.encode_and_sign(user)

        conn
        |> put_status(:created)
        # Pass user, token, and empty snacks list
        |> render(:login, user: user, token: token, snacks: snacks)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(json: FridgeWeb.ChangesetJSON)
        |> render(:error, changeset: changeset)
    end
  end
end
