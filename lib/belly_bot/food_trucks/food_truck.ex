defmodule BellyBot.FoodTrucks.FoodTruck do
  use Ecto.Schema
  import Ecto.Changeset

  schema "food_trucks" do
    field :name, :string
    field :status, :string
    field :location, :map
    field :facility_type, :string
    field :food_items, :string
    field :days_hours, :string
    field :street, :string
    field :lat, :float
    field :lng, :float
    field :schedule, :string

    timestamps(type: :utc_datetime)
  end

  @required_keys [:name, :status, :lng, :lat, :location]
  @optional_keys [
    :food_items,
    :facility_type,
    :street,
    :days_hours,
    :schedule
  ]

  @doc false
  def changeset(food_truck, attrs) do
    food_truck
    |> cast(attrs, @required_keys ++ @optional_keys)
    |> validate_required(@required_keys)
  end
end
