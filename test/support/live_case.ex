defmodule PetaStackExampleWeb.LiveCase do
  @moduledoc """
  This module defines the test case to be used by
  phoenix live view tests.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import Phoenix.LiveViewTest
      import PetaStackExampleWeb.LiveCase

      alias PetaStackExampleWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint PetaStackExampleWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(PetaStackExample.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(PetaStackExample.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
