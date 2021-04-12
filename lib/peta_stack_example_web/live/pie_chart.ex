defmodule PetaStackExampleWeb.Live.PieChart do
  @moduledoc """
  Pie chart live
  """
  use PetaStackExampleWeb, :live_view
  alias PetaStackExample.UserRating
  alias PetaStackExample.Users
  alias PetaStackExampleWeb.PieChartView
  alias PetaStackExampleWeb.Router.Helpers, as: Routes

  def render(assigns) do
    PieChartView.render("index.html", assigns)
  end

  def mount(_params, _session, socket) do
    user_ratings = Users.list_user_ratings()
    changeset = Users.user_rating_changeset(%UserRating{})

    {:ok, assign(socket, changeset: changeset, user_ratings: user_ratings)}
  end

  def handle_event(
        "create_user_rating",
        %{"rating" => params},
        socket
      ) do
    case Users.create_user_rating(params) do
      {:ok, _user_rating} ->
        {:noreply,
         socket
         |> put_flash(:info, "Create user rating successfully")
         |> push_redirect(to: Routes.pie_chart_path(socket, :index))}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
