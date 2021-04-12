defmodule PetaStackExample.UserRating do
  @moduledoc """
  UserRating schema
  """
  use Ecto.Schema
  import Ecto.Changeset
  @timestamps_opts [type: :utc_datetime_usec]

  schema "user_ratings" do
    field :name, :string
    field :quality, :integer

    timestamps()
  end

  @fields ~w(name quality)a

  def changeset(%__MODULE__{} = struct, attrs \\ %{}) do
    struct
    |> cast(attrs, @fields)
  end
end
