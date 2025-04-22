defmodule Fridge.Factory do
  use ExMachina.Ecto, repo: Fridge.Repo

  alias Fridge.Users.User
  alias Fridge.Foods.Food
  alias Fridge.Snacks.Snack

  def user_factory do
    %User{
      email: sequence(:email, &"user-#{&1}@example.com"),
      password_hash: Argon2.hash_pwd_salt("password123")
    }
  end

  def food_factory do
    %Food{
      name: sequence(:name, &"Food #{&1}"),
      cals_per_serv: 42,
      car_per_serv: 42,
      fat_per_serv: 42,
      fib_per_serv: 42,
      pro_per_serv: 42,
      serv_size: 1.0,
      serv_unit: "cup"
    }
  end

  def snack_factory do
    %Snack{
      eaten_on: ~U[2025-04-22 12:00:00Z],
      food: build(:food)
    }
  end

  # For creating users with password (for tests that need login)
  def with_password(user, password \\ "password123") do
    user
    |> Map.put(:password, password)
  end
end
