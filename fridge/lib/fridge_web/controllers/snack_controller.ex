defmodule FridgeWeb.SnackController do
  use FridgeWeb, :controller

  alias Fridge.Snacks
  alias Fridge.Snacks.Snack

  action_fallback FridgeWeb.FallbackController

  def index(conn, _params) do
    snacks = Snacks.list_snacks()
    render(conn, :index, snacks: snacks)
  end

  def create(conn, %{"snack" => snack_params}) do
    with {:ok, %Snack{} = snack} <- Snacks.create_snack(snack_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/v1/snacks/#{snack}")
      |> render(:show, snack: snack)
    end
  end

  def show(conn, %{"id" => id}) do
    snack = Snacks.get_snack!(id)
    render(conn, :show, snack: snack)
  end

  def update(conn, %{"id" => id, "snack" => snack_params}) do
    snack = Snacks.get_snack!(id)

    with {:ok, %Snack{} = snack} <- Snacks.update_snack(snack, snack_params) do
      render(conn, :show, snack: snack)
    end
  end

  def delete(conn, %{"id" => id}) do
    snack = Snacks.get_snack!(id)

    with {:ok, %Snack{}} <- Snacks.delete_snack(snack) do
      send_resp(conn, :no_content, "")
    end
  end
end
