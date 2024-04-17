defmodule BellyBot.Repo.Migrations.CreateFoodTrucks do
  use Ecto.Migration

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

    # flush()
    # FoodTrucks.refetch_data()
  end
end
