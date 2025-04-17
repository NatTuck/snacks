defmodule Fridge.Repo.Migrations.CreateFoods do
  use Ecto.Migration

  def change do
    create table(:foods) do
      add :name, :string, null: false
      add :cals_per_serv, :integer, null: false
      add :serv_size, :integer, null: false
      add :serv_unit, :string, null: false
      add :car_per_serv, :integer
      add :fat_per_serv, :integer
      add :pro_per_serv, :integer
      add :fib_per_serv, :integer
      add :user_id, references(:users, on_delete: :restrict), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:foods, [:user_id])
    create index(:foods, [:name])
  end
end
