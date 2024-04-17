defmodule BellyBot.FoodTrucksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BellyBot.FoodTrucks` context.
  """

  alias BellyBot.Repo
  alias BellyBot.FoodTrucks.FoodTruck

  @doc """
  Generate a food_truck.
  """
  def food_truck_fixture(attrs \\ %{}) do

    attrs = 
      attrs
      |> Enum.into(%{
        days_hours: "some days_hours",
        facility_type: "some facility_type",
        food_items: "some food_items",
        lat: 120.5,
        lng: 120.5,
        location: %{},
        name: "some name",
        schedule: "some schedule",
        status: "some status",
        street: "some street"
      })

    {:ok, food_truck} =
      %FoodTruck{}
      |> FoodTruck.changeset(attrs)
      |> Repo.insert()

    food_truck
  end
end

