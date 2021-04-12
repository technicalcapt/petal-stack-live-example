defmodule PetaStackExampleWeb.Live.PieChart do
  @moduledoc """
  Pie chart live
  """
  use PetaStackExampleWeb, :live_view
  alias PetaStackExample.Repo
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

    a_to_i = sum_quality("a", "i")
    j_to_r = sum_quality("j", "r")
    s_to_z = sum_quality("s", "z")

    str_qualities = Enum.join([a_to_i, j_to_r, s_to_z], ",")

    {:ok,
     assign(socket,
       changeset: changeset,
       user_ratings: user_ratings,
       str_qualities: str_qualities
     )}
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

  defp sum_quality(from, to) do
    custom_query =
      "SELECT SUM (quality) FROM user_ratings WHERE lower(name) SIMILAR TO '[#{from}-#{to}]%'"

    case Repo.query(custom_query) do
      {:ok, %{rows: [[sum_quality | _]]}} ->
        sum_quality

      {:error, _} ->
        0
    end
  end
end
