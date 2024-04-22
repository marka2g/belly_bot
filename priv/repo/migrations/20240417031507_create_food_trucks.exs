defmodule BellyBot.Repo.Migrations.CreateFoodTrucks do
  use Ecto.Migration

  alias BellyBot.FoodTrucks.FoodTruck

  # alias BellyBot.FoodTrucks

  def change do
    create table(:food_trucks) do
      add :name, :string
      add :facility_type, :string
      add :food_items, :text
      add :days_hours, :string
      add :street, :string
      add :lat, :float
      add :lng, :float
      add :location, :map
      add :status, :string
      add :schedule, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:food_trucks, [:name])

    flush()

    %BellyBot.FoodTrucks.FoodTruck{
      name: "Ziaurehman Amini",
      status: "REQUESTED",
      location: %{
        "human_address" => "{\"address\": \"\", \"city\": \"\", \"state\": \"\", \"zip\": \"\"}",
        "latitude" => "37.794331003246846",
        "longitude" => "-122.39581105302317"
      },
      facility_type: "Push Cart",
      food_items: nil,
      days_hours: nil,
      street: "MARKET ST: DRUMM ST intersection",
      lat: -122.39581105302317,
      lng: 37.794331003246846,
      schedule: "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=15MFF-0159&ExportPDF=1&Filename=15MFF-0159_schedule.pdf"
    } |> BellyBot.Repo.insert!(on_conflict: :nothing)
  end
end
