defmodule PetaStackExampleWeb.Live.PieChartTest do
  use PetaStackExampleWeb.LiveCase
  alias PetaStackExample.Repo
  alias PetaStackExample.UserRating

  test "connected mount", %{conn: conn} do
    path = live_path(conn)
    assert {:ok, _view, html} = live(conn, path)
    assert html =~ "User Ratings Pie Chart"
  end

  test "Create user rating", %{conn: conn} do
    path = live_path(conn)
    assert {:ok, view, _html} = live(conn, path)

    assert view
           |> element("#user-rating-form")
           |> render_submit(%{rating: %{name: "test user", quality: 8}})

    assert {:ok, _view, html} = live(conn, path)
    assert html =~ "test user"
    assert html =~ "8%"

    assert Repo.all(UserRating) |> length() == 1
  end

  defp live_path(conn), do: Routes.pie_chart_path(conn, :index)
end
