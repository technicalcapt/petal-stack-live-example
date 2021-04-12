defmodule PetaStackExample.Seeder do
  @moduledoc """
  Seeder module
  """
  alias PetaStackExample.Repo
  alias PetaStackExample.UserRating

  @entries [
    %{
      name: "Aldo Raine",
      quality: 8
    },
    %{
      name: "Boba Fett",
      quality: 8
    },
    %{
      name: "Frank Furter",
      quality: 9
    },
    %{
      name: "Marsellus Wallace",
      quality: 25
    },
    %{
      name: "Sofie Fatale",
      quality: 100
    },
    %{
      name: "Zed",
      quality: 50
    }
  ]

  def seed_user_ratings do
    timestamps = %{
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    }

    entries =
      for entry <- @entries do
        Map.merge(entry, timestamps)
      end

    Repo.insert_all(UserRating, entries)
  end
end
