defmodule Fridge.Snacks.Snack do
  use Ecto.Schema
  import Ecto.Changeset

  schema "snacks" do
    field :eaten_on, :date
    field :user_id, :id
    field :food_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(snack, attrs) do
    snack
    |> cast(attrs, [:eaten_on, :user_id, :food_id])
    |> validate_required([:eaten_on, :user_id, :food_id])
  end
end
