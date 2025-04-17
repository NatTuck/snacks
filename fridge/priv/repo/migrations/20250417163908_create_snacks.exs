defmodule Fridge.Repo.Migrations.CreateSnacks do
  use Ecto.Migration

  def change do
    create table(:snacks) do
      add :eaten_on, :date, null: false
      add :user_id, references(:users, on_delete: :restrict), null: false
      add :food_id, references(:foods, on_delete: :restrict), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:snacks, [:user_id])
    create index(:snacks, [:food_id])
    create index(:snacks, [:eaten_on])
  end
end
