# Run with:    mix run priv/repo/seeds.exs

alias BellyBot.FoodTrucks.FoodTruck
alias BellyBot.Repo

Repo.delete_all(FoodTruck)

food_trucks_data =
  Req.get!("https://data.sfgov.org/resource/rqzj-sfat.json").body

food_trucks =
  Enum.map(food_trucks_data, fn food_truck ->
    for {key, val} <- food_truck, into: %{}, do: {String.to_atom(key), val}
  end)

for truck <- food_trucks do
  food_items =
    case truck |> Map.has_key?(:fooditems) do
      true -> truck.fooditems
      _ -> ""
    end

  days_hours = if truck |> Map.has_key?(:dayshours), do: truck.dayshours, else: ""
  street = if truck |> Map.has_key?(:locationdescription), do: truck.locationdescription, else: ""
  facility_type = if truck |> Map.has_key?(:facilitytype), do: truck.facilitytype, else: ""

  attrs = %{
    name: truck.applicant,
    facility_type: facility_type,
    food_items: food_items,
    street: street,
    days_hours: days_hours,
    lng: truck.latitude,
    lat: truck.longitude,
    location: truck.location,
    schedule: truck.schedule,
    status: truck.status
  }

  FoodTruck.changeset(%FoodTruck{}, attrs)
end
|> Enum.each(fn food_truck ->
  Repo.insert!(food_truck, on_conflict: :nothing)
end)
