defmodule FridgeWeb.SnackJSON do
  alias Fridge.Snacks.Snack

  @doc """
  Renders a list of snacks.
  """
  def index(%{snacks: snacks}) do
    %{data: for(snack <- snacks, do: data(snack))}
  end

  @doc """
  Renders a single snack.
  """
  def show(%{snack: snack}) do
    %{data: data(snack)}
  end

  defp data(%Snack{} = snack) do
    %{
      id: snack.id,
      eaten_on: snack.eaten_on
    }
  end
end
