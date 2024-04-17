defmodule BellyBot.FoodTrucksTest do
  use BellyBot.DataCase

  alias BellyBot.FoodTrucks

  describe "food_trucks" do
    import BellyBot.FoodTrucksFixtures

    test "list_food_trucks/0 returns all food_trucks" do
      food_truck = food_truck_fixture()
      assert FoodTrucks.list_food_trucks() == [food_truck]
    end

    test "get_food_truck!/1 returns the food_truck with given id" do
      food_truck = food_truck_fixture()
      assert FoodTrucks.get_food_truck!(food_truck.id) == food_truck
    end
  end
end
