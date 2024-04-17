defmodule BellyBotWeb.FoodTruckLive.Index do
  use BellyBotWeb, :live_view

  alias BellyBot.FoodTrucks

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :food_trucks, FoodTrucks.list_food_trucks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Food trucks")
    |> assign(:food_truck, nil)
  end
end
