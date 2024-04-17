defmodule BellyBotWeb.FoodTruckLiveTest do
  use BellyBotWeb.ConnCase

  import Phoenix.LiveViewTest
  import BellyBot.FoodTrucksFixtures

  defp create_food_truck(_) do
    food_truck = food_truck_fixture()
    %{food_truck: food_truck}
  end

  describe "Index" do
    setup [:create_food_truck]

    test "lists all food_trucks", %{conn: conn, food_truck: food_truck} do
      {:ok, _index_live, html} = live(conn, ~p"/")

      assert html =~ "Listing Food trucks"
      assert html =~ food_truck.name
    end
  end

  describe "Show" do
    setup [:create_food_truck]

    test "displays food_truck", %{conn: conn, food_truck: food_truck} do
      {:ok, _show_live, html} = live(conn, ~p"/food_trucks/#{food_truck}")

      assert html =~ "Show Food truck"
      assert html =~ food_truck.name
    end
  end
end
