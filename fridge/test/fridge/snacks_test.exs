defmodule Fridge.SnacksTest do
  use Fridge.DataCase

  alias Fridge.Snacks

  describe "snacks" do
    alias Fridge.Snacks.Snack

    import Fridge.SnacksFixtures

    @invalid_attrs %{eaten_on: nil}

    setup do
      user = insert(:user)
      food = insert(:food)
      valid_attrs = %{eaten_on: ~D[2025-04-16], user_id: user.id, food_id: food.id}
      update_attrs = %{eaten_on: ~D[2025-04-17]}
      
      %{valid_attrs: valid_attrs, update_attrs: update_attrs, user: user, food: food}
    end

    test "list_snacks/0 returns all snacks", %{valid_attrs: valid_attrs} do
      snack = snack_fixture(valid_attrs)
      assert Snacks.list_snacks() == [snack]
    end

    test "get_snack!/1 returns the snack with given id", %{valid_attrs: valid_attrs} do
      snack = snack_fixture(valid_attrs)
      assert Snacks.get_snack!(snack.id) == snack
    end

    test "create_snack/1 with valid data creates a snack", %{valid_attrs: valid_attrs} do
      assert {:ok, %Snack{} = snack} = Snacks.create_snack(valid_attrs)
      assert snack.eaten_on == ~D[2025-04-16]
    end

    test "create_snack/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Snacks.create_snack(@invalid_attrs)
    end

    test "update_snack/2 with valid data updates the snack", %{valid_attrs: valid_attrs, update_attrs: update_attrs} do
      snack = snack_fixture(valid_attrs)
      assert {:ok, %Snack{} = snack} = Snacks.update_snack(snack, update_attrs)
      assert snack.eaten_on == ~D[2025-04-17]
    end

    test "update_snack/2 with invalid data returns error changeset", %{valid_attrs: valid_attrs} do
      snack = snack_fixture(valid_attrs)
      assert {:error, %Ecto.Changeset{}} = Snacks.update_snack(snack, @invalid_attrs)
      assert snack == Snacks.get_snack!(snack.id)
    end

    test "delete_snack/1 deletes the snack", %{valid_attrs: valid_attrs} do
      snack = snack_fixture(valid_attrs)
      assert {:ok, %Snack{}} = Snacks.delete_snack(snack)
      assert_raise Ecto.NoResultsError, fn -> Snacks.get_snack!(snack.id) end
    end

    test "change_snack/1 returns a snack changeset", %{valid_attrs: valid_attrs} do
      snack = snack_fixture(valid_attrs)
      assert %Ecto.Changeset{} = Snacks.change_snack(snack)
    end
  end
end
