defmodule PetaStackExampleWeb.PageController do
  use PetaStackExampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
