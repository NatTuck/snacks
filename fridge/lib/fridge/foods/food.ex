defmodule Fridge.Foods.Food do
  use Ecto.Schema
  import Ecto.Changeset

  schema "foods" do
    field :name, :string
    field :cals_per_serv, :integer
    field :serv_size, :integer
    field :serv_unit, :string
    field :car_per_serv, :integer
    field :fat_per_serv, :integer
    field :pro_per_serv, :integer
    field :fib_per_serv, :integer
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(food, attrs) do
    food
    |> cast(attrs, [:name, :cals_per_serv, :serv_size, :serv_unit, :car_per_serv, :fat_per_serv, :pro_per_serv, :fib_per_serv])
    |> validate_required([:name, :cals_per_serv, :serv_size, :serv_unit, :car_per_serv, :fat_per_serv, :pro_per_serv, :fib_per_serv])
  end
end
